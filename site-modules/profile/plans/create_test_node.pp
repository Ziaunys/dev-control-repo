plan profile::create_test_node () {
  $provision_response = run_task('provision::abs', 'pe-ai-assistant-demo-1-prod.c.team-cd4pe-scratchpad.internal', {
      'action'   => 'provision',
      'platform' => 'ubuntu-2004-x86_64-pooled',
  })
  out::message($provision_response)
}
