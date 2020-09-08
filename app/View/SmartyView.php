<?php
namespace View;

use Smarty;

class SmartyView {
    private $smarty;

    public function __construct () {
        $this->smarty = new Smarty();
        $this->smarty->setTemplateDir('templates');
        $this->smarty->setCompileDir('templates_c');
    }

    public function display ($tpl, $vars = null) {
        if ($vars) $this->assign ($vars);
        $this->smarty->display ("$tpl.tpl");
    }

    public function assign ($vars) {
        foreach ($vars as $key => $value) $this->smarty->assign ($key, $value);
    }

    public function render ($tpl, $vars = null) {
        if ($vars) $this->assign ($vars);
        return $this->smarty->fetch ("$tpl.tpl");
    }
}