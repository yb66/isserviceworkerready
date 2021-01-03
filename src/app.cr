require "kemal"
require "json"


module App
  VERSION = "0.1.0"

  class DetailByBrowser
    include JSON::Serializable
    getter supported : String
    @[JSON::Field(key: "details", emit_null: true)]
    getter details : Array(String) | Nil
    @[JSON::Field(key: "minVersion", emit_null: true)]
    getter minVersion : String | Nil
    @[JSON::Field(key: "icon", emit_null: true)]
    getter icon : String | Nil
    getter name : String

    def deets : Array(String)
      self.details || [] of String
    end

    def supported? : Bool
      self.supported != "no"
    end

    def support
      if self.supported == "0.5"
        "ish"
      elsif self.supported == "1"
        "yes"
      else
        "no"
      end
    end
  end

  class Browser
    include JSON::Serializable
    getter id : String
    getter name : String
  end

  class Feature
    include JSON::Serializable

    getter name : String
    getter description : String
    @[JSON::Field(key: "details", emit_null: true)]
    getter details : Array(String) | Nil
    getter browsers : Array(DetailByBrowser)

    def deets : Array(String)
      self.details || [] of String
    end

    def fid
      App.format_name(self.name)
    end
  end

  class Data
    include JSON::Serializable
    getter browsers : Array(Browser)
    getter features : Array(Feature)
  end


  def self.striptags(str)
    if str =~ /^\<\w+\>/
      i = str.index(">").try{|i| i + 1 }
      e = str.index("<",1)
      str[i...e]
    else
      str
    end
  end

  def self.format_name(str : String)
    self.striptags(str).downcase.gsub(/\s+/, '-')
  end

  get "/demos/:name/**" do |env|
    #env.response.headers["X-Original-URL"] = env.params.url.to_s
    if env.params.url["*"].empty?
      send_file env, "#{Kemal.config.public_folder}/demos/#{env.params.url["name"]}/index.html"
    else
      send_file env, "#{Kemal.config.public_folder}/demos/#{env.params.url["name"]}/#{env.params.url["*"]}"
    end
  end

  get "/" do |env|
    data = File.open("#{Kemal.config.public_folder}/data.json") do |file|
      Data.from_json(file)
    end
    render "src/views/index.ecr", "src/views/layout.ecr"
  end

  public_folder "/home/public"
  port = ARGV[0]?.try &.to_i?
  Kemal.run port
end

