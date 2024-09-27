# secrets.nix stores all sensitive variable names in my configuration; purposely empty variables for the sake of security
{
  githubUsername = "";
  githubToken = "";

  wifiNetwork = {
    ssid = "";
    passkey = "";
  };
}
