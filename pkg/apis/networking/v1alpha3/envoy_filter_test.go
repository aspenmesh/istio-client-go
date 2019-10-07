package v1alpha3

import (
	"bytes"
	"encoding/json"
	"fmt"
	"testing"

	log "github.com/sirupsen/logrus"
	"github.com/stretchr/testify/assert"
	istiov1alpha3 "istio.io/api/networking/v1alpha3"
)

func Test_EnvoyFilter(t *testing.T) {
	buffer := bytes.NewBufferString(`{
		"apiVersion":"networking.istio.io/v1alpha3",
		"kind":"EnvoyFilter",
		"metadata":{
			"name":"test-envoy-filter",
			"namespace":"istio-system"
		},
		"spec":{
			"filters": [
				{
					"filterConfig": {
						"cluster_pattern": "pattern_from.svc.cluster.local",
						"cluster_replacement": "pattern_to.svc.cluster.local"
					},
					"filterName": "envoy.filters.network.tcp_cluster_rewrite",
					"filterType": "NETWORK",
					"insertPosition": {
						"index": "AFTER",
						"relativeTo": "envoy.filters.network.sni_cluster"
					},
					"listenerMatch": {
						"listenerType": "GATEWAY",
						"portNumber": 15013
					}
				}
			]
		}
	}`)

	envoyFilter := EnvoyFilter{}
	err := json.Unmarshal(buffer.Bytes(), &envoyFilter)
	assert.Equal(t, nil, err, "Could not unmarshal message")
	vss := envoyFilter.GetSpecMessage().(*istiov1alpha3.EnvoyFilter)

	log.WithFields(log.Fields{
		"obj":  fmt.Sprintf("%+v", envoyFilter),
		"spec": vss.String(),
	}).Info("Unmarshalled message")

	// metadata
	assert.Equal(t, "networking.istio.io/v1alpha3", envoyFilter.TypeMeta.APIVersion)
	assert.Equal(t, "EnvoyFilter", envoyFilter.TypeMeta.Kind)
	assert.Equal(t, "test-envoy-filter", envoyFilter.GetObjectMeta().GetName())

	// TODO: Not clear how read FilterConfig

	// FilterName
	assert.Equal(t, "envoy.filters.network.tcp_cluster_rewrite", envoyFilter.Spec.Filters[0].FilterName)

	// FilterType
	assert.Equal(t, istiov1alpha3.EnvoyFilter_Filter_NETWORK, envoyFilter.Spec.Filters[0].FilterType)

	// InsertPosition
	assert.Equal(t, istiov1alpha3.EnvoyFilter_InsertPosition_AFTER, envoyFilter.Spec.Filters[0].InsertPosition.Index)
	assert.Equal(t, "envoy.filters.network.sni_cluster", envoyFilter.Spec.Filters[0].InsertPosition.RelativeTo)

	// ListenerMatch
	assert.Equal(t, istiov1alpha3.EnvoyFilter_DeprecatedListenerMatch_GATEWAY, envoyFilter.Spec.Filters[0].ListenerMatch.ListenerType)
	assert.Equal(t, uint32(15013), envoyFilter.Spec.Filters[0].ListenerMatch.PortNumber)
}
