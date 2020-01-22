/*
Portions Copyright 2020 The Kubernetes Authors.
Portions Copyright 2020 Aspen Mesh Authors.

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

// Code generated by client-gen. DO NOT EDIT.

package fake

import (
	v1alpha1 "github.com/aspenmesh/istio-client-go/pkg/client/clientset/versioned/typed/authentication/v1alpha1"
	rest "k8s.io/client-go/rest"
	testing "k8s.io/client-go/testing"
)

type FakeAuthenticationV1alpha1 struct {
	*testing.Fake
}

func (c *FakeAuthenticationV1alpha1) MeshPolicies() v1alpha1.MeshPolicyInterface {
	return &FakeMeshPolicies{c}
}

func (c *FakeAuthenticationV1alpha1) Policies(namespace string) v1alpha1.PolicyInterface {
	return &FakePolicies{c, namespace}
}

// RESTClient returns a RESTClient that is used to communicate
// with API server by this client implementation.
func (c *FakeAuthenticationV1alpha1) RESTClient() rest.Interface {
	var ret *rest.RESTClient
	return ret
}
