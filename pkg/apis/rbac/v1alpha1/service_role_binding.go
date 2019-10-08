/*
Portions Copyright 2017 The Kubernetes Authors.
Portions Copyright 2018 Aspen Mesh Authors.
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
    http://www.apache.org/licenses/LICENSE-2.0
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

package v1alpha1

import (
	"bufio"
	"bytes"
	"log"

	"github.com/gogo/protobuf/jsonpb"
	"github.com/golang/protobuf/proto"
	istiov1alpha1 "istio.io/api/rbac/v1alpha1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
)

// +genclient
// +genclient:noStatus
// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// ServiceRoleBinding is a Istio ServiceRoleBinding resource
type ServiceRoleBinding struct {
	metav1.TypeMeta   `json:",inline"`
	metav1.ObjectMeta `json:"metadata,omitempty"`

	Spec ServiceRoleBindingSpec `json:"spec"`
}

func (p *ServiceRoleBinding) GetSpecMessage() proto.Message {
	return &p.Spec.ServiceRoleBinding
}

// +k8s:deepcopy-gen:interfaces=k8s.io/apimachinery/pkg/runtime.Object

// ServiceRoleBindingList is a list of ServiceRoleBinding resources
type ServiceRoleBindingList struct {
	metav1.TypeMeta `json:",inline"`
	metav1.ListMeta `json:"metadata"`

	Items []ServiceRoleBinding `json:"items"`
}

// ServiceRoleBindingSpec in a wrapper around Istio ServiceRoleBinding
type ServiceRoleBindingSpec struct {
	istiov1alpha1.ServiceRoleBinding
}

// Taken from https://github.com/michaelkipper/istio-client-go/commit/7c8e95b5d9220d47c107bb6f3b0b71fbc8af3ef7#diff-1c6fa6bfc320013a249f4b6d0ccdd928R65
func (p *ServiceRoleBindingSpec) MarshalJSON() ([]byte, error) {
	buffer := bytes.Buffer{}
	writer := bufio.NewWriter(&buffer)
	marshaler := jsonpb.Marshaler{}
	err := marshaler.Marshal(writer, &p.ServiceRoleBinding)
	if err != nil {
		log.Printf("Could not marshal ServiceRoleBinding. Error: %v", err)
		return nil, err
	}

	writer.Flush()
	return buffer.Bytes(), nil
}

func (p *ServiceRoleBindingSpec) UnmarshalJSON(b []byte) error {
	reader := bytes.NewReader(b)
	unmarshaler := jsonpb.Unmarshaler{}
	err := unmarshaler.Unmarshal(reader, &p.ServiceRoleBinding)
	if err != nil {
		log.Printf("Could not unmarshal ServiceRoleBinding. Error: %v", err)
		return err
	}
	return nil
}

// DeepCopyInto is a deepcopy function, copying the receiver, writing into out. in must be non-nil.
// Based of https://github.com/istio/istio/blob/release-0.8/pilot/pkg/config/kube/crd/types.go#L450
func (in *ServiceRoleBindingSpec) DeepCopyInto(out *ServiceRoleBindingSpec) {
	*out = *in
}
