#!/usr/bin/env bash

mkdir -p app/code/Vendor/Example/{etc/hyva_cms,view/frontend/templates/elements}

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

cat > app/code/Vendor/Example/view/frontend/templates/elements/stl.phtml <<'PHP'
<?php // silence is golden
PHP

cat > app/code/Vendor/Example/view/frontend/templates/elements/stl-single.phtml <<'PHP'
<?php // silence is golden
PHP
