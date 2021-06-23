module ShellScriptCron;


event hourly_scripts()
  {
  system("/root/input_files.sh");
  schedule 1min { hourly_scripts() };
  }

event zeek_init() {
  schedule 1min { hourly_scripts() };
}
