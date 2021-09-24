module SpecTestHelper
  def sign_in user
    # 登录
    post "/sessions", params: {email: user.email, password: user.password}
  end
end
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.include SpecTestHelper, :type => :request
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

=begin
  config.disable_monkey_patching!
  config.warnings = true
  if config.files_to_run.one?
  end
  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
=end
end
