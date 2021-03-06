import 'dart:html';

import 'package:dom_builder/dom_builder.dart';

class BootstrapNavbarToggler {
  static DOMGenerator domGenerator = DOMGenerator.dartHTML();

  Element render() {
    var button = $button(
        classes: 'navbar-toggler',
        type: 'button',
        attributes: {
          'data-toggle': 'collapse',
          'data-target': '#navbarCollapse',
          'aria-controls': 'navbarCollapse',
          'aria-expanded': 'false',
          'aria-label': 'Toggle navigation'
        },
        content: $span(classes: 'navbar-toggler-icon'));

    return button.buildDOM(generator: domGenerator);
  }
}
