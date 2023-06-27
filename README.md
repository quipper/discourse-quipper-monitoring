# **Quipper Monitoring** Plugin

**Plugin Summary**

This plugin includes the New Relic and Sentry gems.

Once you have completed the configuration in config.yml for New Relic, it will start working without requiring any additional admin configurations.

For Sentry, you will need to enable it and add the key in the admin settings.

After ensuring that the DSN for Sentry is set and Sentry is enabled from the admin menu, we need to restart the service/pod to ensure that Sentry works correctly.

## how to install
To install the Quipper Monitoring Plugin, follow these steps:

Go to your discourse app.
Inside the "containers" directory, update your app's yml file (e.g., forum.yml).
Fill in the credentials for New Relic.
Rebuild the discourse service.
You're done!