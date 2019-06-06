Pod::Spec.new do |s|

  s.name         = "ReactiveCocoa"
  s.version      = "2.5"
  s.summary      = "The 2.x ReactiveCocoa Objective-C API: Streams of values over time"

  s.description  = <<-DESC.strip_heredoc
                     ReactiveCocoa (formally ReactiveCocoa or RAC) is an Objective-C
                     framework inspired by [Functional Reactive Programming](
                     http://en.wikipedia.org/wiki/Functional_reactive_programming).
                     It provides APIs for composing and **transforming streams of values**.
                   DESC

  s.homepage     = "https://reactivecocoa.io"
  s.screenshots  = "https://reactivecocoa.io/img/logo.png"
  s.license      = { type: "MIT", file: "LICENSE.md" }

  s.documentation_url  = "https://github.com/ReactiveCocoa/ReactiveCocoa/"\
                         "tree/master/Documentation#readme"

  s.author             = "ReactiveCocoa"
  s.social_media_url   = "https://twitter.com/ReactiveCocoa"

  s.ios.deployment_target     = "8.0"
  s.osx.deployment_target     = "10.9"
  s.watchos.deployment_target = "2.0"
  s.tvos.deployment_target    = "9.0"

  s.source = { git: "https://github.com/aiyunxiao/OldReactiveCocoa.git"}

  s.requires_arc = true
  s.frameworks   = "Foundation"
  s.default_subspec = 'UI'
  
  s.subspec 'no-arc' do |noarc|
      noarc.source_files = 'ReactiveCocoa/RACObjCRuntime.{h,m}'
      noarc.requires_arc = false
  end
  
  s.subspec 'Core' do |core|
      core.source_files = 'ReactiveCocoa/*.{d,h,m}', 'ReactiveCocoa/extobjc/*.{h,m}'
      core.private_header_files = 'ReactiveCocoa/*Private.h'
      core.exclude_files = 'ReactiveCocoa/*{RACObjCRuntime,AppKit,NSControl,NSText,UIActionSheet,UI,MK}*'
      core.dependency 'ReactiveCocoa/no-arc'
  end
  
  s.subspec 'UI' do |ui|
      ui.source_files = 'ReactiveCocoa/*{AppKit,NSControl,NSText,UI,MK}*'
      ui.ios.exclude_files = 'ReactiveCocoa/*{AppKit,NSControl,NSText}*'
      ui.dependency  'ReactiveCocoa/Core'
  end
  
  s.prepare_command = <<-'CMD'.strip_heredoc
  find . \( -regex '.*EXT.*\\.[mh]$' -o -regex '.*metamacros\\.[mh]$' \) -execdir mv {} RAC{} \;
  find . -regex '.*\\.[hm]' -exec sed -i '' -E 's@\"(EXT.*|metamacros)\\.h\"@\"RAC\\1.h\"@' {} \;
  find . -regex '.*\\.[hm]' -exec sed -i '' -E 's@<ReactiveCocoa/(EXT.*)\\.h>@<ReactiveCocoa/RAC\\1.h>@' {} \;
  CMD

end
