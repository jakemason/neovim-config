<?php

$config = new PhpCsFixer\Config();

return $config->setRules([
    '@PSR12'                  => true,
    '@PhpCsFixer'             => true,
    'array_syntax'            => ['syntax' => 'short'],
    'binary_operator_spaces'  => ['default' => 'align_single_space_minimal'],
    'global_namespace_import' => [
        'import_classes'   => true,
        'import_constants' => true,
        'import_functions' => false,
    ],
    'concat_space' => ['spacing' => 'one'],
]);
