const innoSetup = require("innosetup-compiler");
const cp = require("child_process");
const path = require("path");
const compilerPath = path.join(
  __dirname,
  "node_modules/innosetup-compiler/bin/ISCC.exe"
);
const execute = cp.spawn(compilerPath, [
  "test.iss",
  "/dMyAppName=electron testing",
  "/dMyAppVersion=2.0"
]);
execute.stdout.on("data", data => {
  console.log(`stdout: ${data}`);
});
execute.on("error", error => {
  console.log(`error: ${error}`);
});
execute.on("close", code => {
  console.log(`child process exited with code ${code}`);
});
