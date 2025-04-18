plan profile::create_test_node () {
  $provision_response = run_task('provision::abs', 'pe-ai-assistant-demo-1-prod.c.team-cd4pe-scratchpad.internal', {
      'action'   => 'provision',
      'platform' => 'ubuntu-2004-x86_64-pooled',
  })
  out::message($provision_response)
  $test_node = $provision_response[0].value['nodes'][0]
  $target_config = {
    'name' => $test_node['hostname'],
    'config' => {
      'transport' => 'ssh',
      'ssh' => {
        'user'           => 'root',
        'host-key-check' => false,
        'private-key'    => '/opt/puppetlabs/server/data/orchestration-services/id_rsa',
      },
    },
  }
  $test_target = Target.new($target_config)
  run_command('curl -k https://pe-ai-assistant-demo-1-prod.c.team-cd4pe-scratchpad.internal:8140/packages/current/install.bash | sudo bash', $test_target)
  run_command('puppet agent -t', $test_target)
  return $test_node['hostname']
}
