#!/usr/bin/env bash

mkdir -p app/code/Vendor/Example/{etc/hyva_cms,etc/frontend,Observer,view/frontend/{templates/elements,tailwind}}

cat > app/code/Vendor/Example/registration.php <<'PHP'
<?php
declare(strict_types=1);

use Magento\Framework\Component\ComponentRegistrar;

ComponentRegistrar::register(
    ComponentRegistrar::MODULE,
    'Vendor_Example',
    __DIR__
);
PHP

cat > app/code/Vendor/Example/etc/module.xml <<'XML'
<?xml version="1.0"?>
<config xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:noNamespaceSchemaLocation="urn:magento:framework:Module/etc/module.xsd">
    <module name="Vendor_Example"/>
</config>
XML

cat > app/code/Vendor/Example/etc/hyva_cms/components.json <<'JSON'
{}
JSON

cat > app/code/Vendor/Example/etc/frontend/events.xml <<'XML'
<?xml version="1.0" ?>
<config
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:noNamespaceSchemaLocation="urn:magento:framework:Event/etc/events.xsd"
>
    <event name="hyva_config_generate_before">
        <observer
            name="Vendor_Module_HyvaConfigGenerateBefore"
            instance="Vendor\Example\Observer\RegisterModuleForHyvaConfig"
        />
    </event>
</config>
XML

cat > app/code/Vendor/Example/Observer/RegisterModuleForHyvaConfig.php <<'PHP'
<?php
declare(strict_types=1);

namespace Vendor\Example\Observer;

use Magento\Framework\Component\ComponentRegistrar;
use Magento\Framework\Event\Observer;
use Magento\Framework\Event\ObserverInterface;

/**
 * Class RegisterModuleForHyvaConfig: Register the module for the Hyva config
 */
class RegisterModuleForHyvaConfig implements ObserverInterface
{
    public function __construct(
        private readonly ComponentRegistrar $componentRegistrar
    ) {
    }

    public function execute(Observer $event)
    {
        $config = $event->getData('config');
        $extensions = $config->hasData('extensions') ? $config->getData('extensions') : [];

        $moduleName = implode('_', array_slice(explode('\\', __CLASS__), 0, 2));
        $path = $this->componentRegistrar->getPath(ComponentRegistrar::MODULE, $moduleName);

        $extensions[] = ['src' => substr($path, strlen(BP) + 1)];
        $config->setData('extensions', $extensions);
    }
}
PHP

cat > app/code/Vendor/Example/view/frontend/templates/elements/stl.phtml <<'PHP'
<?php
declare(strict_types=1);

use Hyva\CmsLiveviewEditor\Block\Element;
use Hyva\Theme\Model\ViewModelRegistry;
use Magento\Framework\Escaper;

/** @var Element $block */
/** @var Escaper $escaper */
/** @var ViewModelRegistry $viewModels*/

$children = $block->getChildren();
$image = $block->getImage() ?? [];
$imageSrc = @$image['src'] ?? '';
?>
PHP

cat > app/code/Vendor/Example/view/frontend/templates/elements/stl-single.phtml <<'PHP'
<?php
declare(strict_types=1);

use Hyva\CmsLiveviewEditor\Block\Element;
use Hyva\Theme\Model\ViewModelRegistry;
use Magento\Framework\Escaper;

/** @var Element $block */
/** @var Escaper $escaper */
/** @var ViewModelRegistry $viewModels*/
?>
PHP

cat > app/code/Vendor/Example/view/frontend/tailwind/tailwind.config.js <<'JS'
module.exports = {
    content: ["../templates/**/*.phtml"],
};
JS
