class magento::n98magerun(
  $install_magento     = true,
  $magento_version     = "magento-ce-1.7.0.2",
  $install_sample_data = true
) {
    class { "::n98magerun": }

    if $install_magento == true {
      class { "::n98magerun::install":
        magento_version     => $magento_version,
        installation_folder => "/vagrant_data/htdocs",
        db_host             => "localhost",
        db_user             => "root",
        db_pass             => "root",
        db_name             => "magento",
        base_url            => "http://magento.dev",
        install_sample_data => $install_sample_data
      }
    }
}