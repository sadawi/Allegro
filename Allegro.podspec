Pod::Spec.new do |s|
    s.name             = "Allegro"
    s.version          = "0.1.0"
    s.summary          = "Swift music theory"
    s.homepage         = "https://github.com/sadawi/Allegro"
    s.license          = 'MIT'
    s.author           = { "Sam Williams" => "samuel.williams@gmail.com" }
    s.source           = { :git => "https://github.com/sadawi/Allegro.git", :tag => s.version.to_s }

    s.platform     = :ios, '8.0'
    s.requires_arc = true

    s.source_files = 'Allegro/**/*'
    s.resource_bundles = {
    'Allegro' => ['Allegro/*.png']
    }
end
