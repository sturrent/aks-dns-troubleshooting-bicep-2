param privateDnsZoneName string
param privateDnsZoneLinkName string
param aksVnetId string
param recordName string

resource privateDnsZone 'Microsoft.Network/privateDnsZones@2020-06-01' = {
  name: privateDnsZoneName
  location: 'global'

  resource link 'virtualNetworkLinks' = {
    name: privateDnsZoneLinkName
    location: 'global'
    properties: {
      registrationEnabled: false
      virtualNetwork: { id: aksVnetId }
    }
  }

  resource aRecord 'A' = {
    name: recordName
    properties: {
      ttl: 3600
      aRecords: [
        {
          ipv4Address: '10.100.0.7'
        }
      ]
    }
  }
}
