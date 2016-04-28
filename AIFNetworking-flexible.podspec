Pod::Spec.new do |s|
  s.name     = 'AIFNetworking-flexible.podspec'
  s.version  = '1.0'
  s.summary  = 'Anjuke iOS Framework: Networking, '
  s.authors  = { 'Ryan' => 'czwen1993@gmail.com' }
  s.source   = { :git => 'https://github.com/casatwy/RTNetworking.git' }
  s.requires_arc = true
  s.ios.deployment_target = '7.0'
  s.frameworks = 'Security'

  s.source_files = 	'RTNetworking/Components/*.{h,m}',
  			'RTNetworking/Components/Assistants/*.{h,m}',
  			'RTNetworking/Components/Categories/*.{h,m}',
  			'RTNetworking/Components/Components/*.{h,m}'
  			'RTNetworking/Components/Services/*.{h,m}'



  s.subspec 'Components' do |ss|
    ss.source_files = 'RTNetworking/Components/Components/*.{h,m}'
    ss.frameworks = 'SystemConfiguration'
    ss.subspec 'LocationComponents' do |sss|
        sss.source_files = 'RTNetworking/Components/Components/LocationComponents/**/*.{h,m}'
    end
    ss.subspec 'LogComponents' do |sss|
        sss.source_files = 'RTNetworking/Components/Components/LogComponents/*.{h,m}'
    end
    ss.subspec 'CacheComponents' do |sss|
        sss.source_files = 'RTNetworking/Components/Components/CacheComponents/*.{h,m}'
    end
  end

  s.subspec 'Services' do |ss|
    ss.source_files = 'RTNetworking/Components/Services/*.{h,m}'
  end
end
