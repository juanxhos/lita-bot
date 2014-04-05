require 'ostruct'

Lita.configure do |config|

  robot_config = OpenStruct.new YAML.load_file("#{File.dirname(__FILE__)}/config/robot.yml")
  config.robot.name = robot_config.name
  config.robot.mention_name = robot_config.mention_name
  config.robot.alias = robot_config.alias

  # The locale code for the language to use.
  config.robot.locale = robot_config.locale

  ### lita-slack adapter config
  slack_config = OpenStruct.new YAML.load_file("#{File.dirname(__FILE__)}/config/slack.yml")

  config.adapter.username = slack_config.username
  config.adapter.add_mention = slack_config.add_mention
  config.adapter.incoming_token = slack_config.incoming_token
  config.adapter.team_domain = slack_config.team_domain
  config.handlers.slack_handler.webhook_token = slack_config.webhook_token
  config.handlers.slack_handler.team_domain = slack_config.team_domain

  # This param will make the bot to listen to all messages
  config.adapter.private_chat = true

  # The severity of messages to log. Options are:
  # :debug, :info, :warn, :error, :fatal
  # Messages at the selected level and above will be logged.
  config.robot.log_level = :info

  # An array of user IDs that are considered administrators. These users
  # the ability to add and remove other users from authorization groups.
  # What is considered a user ID will change depending on which adapter you use.
  config.robot.admins = robot_config.admins

  # The adapter you want to connect with. Make sure you've added the
  # appropriate gem to the Gemfile.
  config.robot.adapter = robot_config.adapter

  config.http.port = robot_config.port unless [:shell, :console].include? config.robot.adapter

  # Set options for the Redis connection.
  redis_config = OpenStruct.new YAML.load_file('config/redis.yml')
  config.redis.host = redis_config.host
  config.redis.port = redis_config.port

  # For server hook
  config.handlers.hook_forward.default_room = robot_config.hook_forward_default_room

  # For Gitlab integration

  # For Gitlab2Jenkins GHP integration
  gitlab_config = OpenStruct.new YAML.load_file('config/gitlab2jenkinsghp.yml')
  config.handlers.gitlab2jenkins_ghp.room                 = gitlab_config.room
  config.handlers.gitlab2jenkins_ghp.url_gitlab           = gitlab_config.url_gitlab
  config.handlers.gitlab2jenkins_ghp.group                = gitlab_config.group
  config.handlers.gitlab2jenkins_ghp.url_jenkins          = gitlab_config.url_jenkins
  config.handlers.gitlab2jenkins_ghp.private_token_gitlab = gitlab_config.private_token_gitlab


  #config.gitlab.client(:endpoint => gitlab_config.url_gitlab + '/api/v3')

  config.handlers.google_images.safe_search = :off
  config.handlers.giphy.api_key = 'dc6zaTOxFJmzC' # This is the only public api key

  jenkins_config = OpenStruct.new YAML.load_file('config/jenkins.yml')
  config.handlers.jenkins.url  = jenkins_config.url
  config.handlers.jenkins.auth = jenkins_config.auth

  imgflip_config = OpenStruct.new YAML.load_file("#{File.dirname(__FILE__)}/config/imgflip.yml")
  config.handlers.imgflip.command_only = imgflip_config.command_only
  config.handlers.imgflip.username = imgflip_config.username
  config.handlers.imgflip.password = imgflip_config.password

end

Lita.load_locales Dir[File.expand_path(
                          File.join("..", "..", "locales", "*.yml"), __FILE__
                      )]