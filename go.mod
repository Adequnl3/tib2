module github.com/TykTechnologies/tyk-identity-broker

go 1.13

require (
	github.com/Jeffail/gabs v1.4.0
	github.com/TykTechnologies/tyk/certs v0.0.1 // indirect
	github.com/crewjam/saml v0.4.0
	github.com/go-ldap/ldap v3.0.3+incompatible
	github.com/go-redis/redis v6.15.6+incompatible
	github.com/google/go-cmp v0.5.0 // indirect
	github.com/gorilla/mux v1.7.4
	github.com/gorilla/sessions v1.2.0
	github.com/kelseyhightower/envconfig v1.4.0
	github.com/markbates/goth v1.64.2
	github.com/mattn/go-colorable v0.1.7 // indirect
	github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d // indirect
	github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e // indirect
	github.com/onsi/ginkgo v1.14.0 // indirect
	github.com/satori/go.uuid v1.2.0
	github.com/sirupsen/logrus v1.4.3-0.20191026113918-67a7fdcf741f
	github.com/stretchr/objx v0.1.1 // indirect
	github.com/stretchr/testify v1.6.1 // indirect
	github.com/x-cray/logrus-prefixed-formatter v0.5.2
	golang.org/x/crypto v0.0.0-20200709230013-948cd5f35899 // indirect
	golang.org/x/oauth2 v0.0.0-20200107190931-bf48bf16ab8d
	golang.org/x/text v0.3.3
	gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f // indirect
	gopkg.in/mgo.v2 v2.0.0-20190816093944-a6b53ec6cb22
)

replace github.com/jensneuse/graphql-go-tools => github.com/TykTechnologies/graphql-go-tools v1.6.2-0.20200731074614-80c67fc17e8e
