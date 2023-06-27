# **Quipper Monitoring** Plugin

**Plugin Summary**

This plugin includes the New Relic and Sentry gems.

For New Relic, once you complete the config.yml, it will start working without requiring any additional admin configurations.

For Sentry, you will need to enable it and add the key in the admin settings.

After ensuring that the DSN for Sentry is set and Sentry is enabled from the admin menu, we need to restart the service/pod to ensure that Sentry works correctly.

## how to install

- Go to your discourse app
- Inside containers directory update your app `yml` file ex: `forum.yml`
- Fill credentials for newrelic
- Rebuild the discourse service
- Done
