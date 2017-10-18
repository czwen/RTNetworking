Pod::Spec.new do |s|
  s.name     = "FlexibleAIFNetworking"

  s.version  = "1.0.9"

  s.license = { :type => "MIT" }

  s.summary  = "Anjuke iOS Framework: Networking, flexible by Ryan"

  s.author = { "ChenZhiWen" => "czwen1993@gmail.com" }

  s.source   = { :git => "https://github.com/czwen/RTNetworking.git" }

  s.homepage = "https://github.com/czwen/RTNetworking"

  s.requires_arc = true

  s.ios.deployment_target = "7.0"

  s.frameworks = "Security"

  s.dependency "AFNetworking"

  s.source_files = 	"RTNetworking/Components/*.{h,m}",
  			"RTNetworking/Components/Assistants/*.{h,m}",
  			"RTNetworking/Components/Categories/*.{h,m}",
  			"RTNetworking/Components/Components/*.{h,m}",
  			"RTNetworking/Components/Services/*.{h,m}",
  			"RTNetworking/Components/Components/LogComponents/*.{h,m}",
  			"RTNetworking/Components/Components/CacheComponents/*.{h,m}"



#  s.subspec "Components" do |ss|
#    ss.source_files = "RTNetworking/Components/Components/*.{h,m}"
#    ss.frameworks = "SystemConfiguration"
#    ss.subspec "LocationComponents" do |sss|
#        sss.source_files = "RTNetworking/Components/Components/LocationComponents/**/*.{h,m}"
#    end
#  end

#  s.subspec "Services" do |ss|
#    ss.source_files = "RTNetworking/Components/Services/*.{h,m}",
#		        "RTNetworking/Components/Assistants/*.{h,m}",
#    		        "RTNetworking/Components/Categories/*.{h,m}"
#  end

end