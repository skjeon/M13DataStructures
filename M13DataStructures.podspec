Pod::Spec.new do |s|



  s.name         = "M13DataStructures"
  s.version      = "1.0.0"
  s.summary      = "M13DataStructures contains implementations of several data structures in swift."

  s.description  = <<-DESC
                   M13DataStructures contains implementations of several data structures in swift. Included are implementations for a Stack, 2D Matrix, and Ordered Dictionary.
                   DESC

  s.homepage     = "https://github.com/Marxon13/M13DataStructures"

  s.license      = {:type => 'MIT',
                    :text => <<-LICENSE
 Copyright (c) 2014 Brandon McQuilkin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

    LICENSE
 }

  s.author       = { "Brandon McQuilkin" => "brandon.mcquilkin@gmail.com" }

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'

  s.source       = { :git => "https://github.com/Marxon13/M13DataStructures.git", :tag => "v#{s.version}" }

  s.source_files  = 'Classes/*'

  s.framework  = 'Foundation'

  s.requires_arc = true

end
