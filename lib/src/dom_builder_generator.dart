
import 'dom_builder_base.dart';

import 'dom_builder_generator_none.dart'
  if (dart.library.html) "dom_builder_generator_dart_html.dart"
;

abstract class DOMGenerator<T> {

  static DOMGeneratorDartHTML _dartHTML ;

  static DOMGeneratorDartHTML<T> dartHTML<T>() {
    _dartHTML ??= createDOMGeneratorDartHTML() ;
    return _dartHTML as DOMGeneratorDartHTML<T> ;
  }

  T generate( DOMElement root ) {
    return build(null, null, root) ;
  }

  T build( DOMElement domParent, T parent, DOMNode domNode ) {
    if ( domNode is DOMElement ) {
      return buildElement(domParent, parent, domNode) ;
    }
    else if ( domNode is TextNode ) {
      buildText(domParent, parent, domNode) ;
      return null ;
    }
    else if ( domNode is ExternalElementNode ) {
      return buildExternalElement(domParent, parent, domNode) ;
    }
    else {
      throw StateError("Can't build node of type: ${ domNode.runtimeType }");
    }
  }

  String buildText( DOMElement domParent, T parent, TextNode domNode ) {
    var text = getNodeText(domNode);
    if (parent != null) {
      appendElementText(parent, text) ;
    }
    return text ;
  }


  String getNodeText(TextNode domNode) ;

  void appendElementText(T element, String text) ;

  T buildElement( DOMElement domParent, T parent, DOMElement domElement ) {

    var element = createElement( domElement.tag ) ;
    setAttributes(domElement, element);

    var length = domElement.length;

    for (var i = 0; i < length; i++) {
      var node = domElement.nodeByIndex(i);

      build(domElement, element, node);
    }

    if (parent != null) {
      addChildToElement(parent, element);
    }

    return element ;
  }

  T buildExternalElement( DOMElement domParent, T parent, ExternalElementNode domElement ) {
    var element = domElement.element ;

    if (parent != null) {
      return addExternalElementToElement(parent, element);
    }

    return null ;
  }

  void addChildToElement(T element, T child) ;

  bool canHandleExternalElement( dynamic externalElement ) ;

  T addExternalElementToElement(T element, dynamic externalElement) ;

  T createElement(String tag) ;

  void setAttributes( DOMElement domElement , T element ) {
    for (var attrName in domElement.attributesNames ) {
      var attrVal = domElement[attrName] ;
      setAttribute(element, attrName, attrVal);
    }
  }

  void setAttribute(T element, String attrName, String attrVal) ;

}

abstract class DOMGeneratorDartHTML<T> extends DOMGenerator<T> {

}
