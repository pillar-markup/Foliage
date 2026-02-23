Class {
	#name : 'FOWebSitePluginTest',
	#superclass : 'FOAbstractWebSiteTest',
	#category : 'Foliage-Core-Tests-Blog',
	#package : 'Foliage-Core-Tests',
	#tag : 'Blog'
}

{ #category : 'tests' }
FOWebSitePluginTest >> testHandlePlugins [

	
	"so far we cannot really tests handleplugins in a generic manner since it is 
	only defined in a super ad-hoc way. At least it should not bark when there is no plugins."
	
	"see `FOPublicationPageTest>>#testHandlePlugins`"
	self shouldnt: [ site handlePlugins ] raise: SubscriptOutOfBounds 
]
