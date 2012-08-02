Pod::Spec.new do |s|
  s.name         = 'stl-oauth-client'
  s.version      = '1.1.0'
  s.summary      = 'OAuth 1.0a client using AFNetwork.'
  s.description  = 'Add the AFNetwork and both files, call - setConsumerKey:secret: and - setAccessToken:secret to set the signing parameters and all calls after that will be signed. If you want a non-authenticated call, use either - unsignedRequestWithMethod:path:parameters: or - setSignRequests(NO).'
  s.homepage     = 'https://github.com/jonah-carbonfive/stl-oauth-client'
  s.license      = { :type => 'BSD', :text => <<EOL
Copyright (c) 2012
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:

- Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.

- Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
EOL
  }
  s.authors      = { 'Jonah Williams' => 'jonah@carbonfive.com', 'Marcelo Alves' => 'marcelo.alves@me.com' }
  s.source       = { :git => "https://github.com/jonah-carbonfive/stl-oauth-client.git" }
  s.source_files = '*.{h,m}'
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 1.0RC1'
end
