%class_name SGFParser
%token_type SGFToken
%nonterminal_type prop_value_list "[String]"
%nonterminal_type property "(String, [String])"
%nonterminal_type property_list "[(String, [String])]"
%nonterminal_type node SGFNode
%nonterminal_type sequence SGFNode
%nonterminal_type gametree SGFNode
%nonterminal_type gametree_list "[SGFNode]"
%nonterminal_type collection "[SGFNode]"
%nonterminal_type output "[SGFNode]"

output ::= collection(a). {
    return a
}

collection ::= gametree(a). {
    return [a]
}
collection ::= gametree(a) collection(b). {
    return [a] + b
}

gametree ::= OPEN_PARENTHESIS sequence(a) CLOSE_PARENTHESIS. {
    return a
}
gametree ::= OPEN_PARENTHESIS sequence(a) gametree_list(b) CLOSE_PARENTHESIS. {
    var node = a
    while node.children.count > 0 {
        node = node.children[0]
    }
    node.children.append(contentsOf: b)
    return a
}

gametree_list ::= gametree(a). {
    return [a]
}
gametree_list ::= gametree(a) gametree_list(b). {
    return [a] + b
}

sequence ::= node(a). {
    return a
}
sequence ::= node(a) sequence(b). {
    a.children.append(b)
    return a
}

node ::= SEMICOLUMN. {
    return SGFNode()
}
node ::= SEMICOLUMN property_list(a). {
    let node = SGFNode()
    for (k, v) in a {
        node.properties[k] = v
    }
    return node
}

property_list ::= property(a). {
    return [a]
}
property_list ::= property(a) property_list(b). {
    return [a] + b
}

property ::= PROP_INDENT(a) prop_value_list(b). {
    return (a.toIdentifierString()!, b)
}

prop_value_list ::= VALUE(a). {
    return [a.toValueString()!]
}
prop_value_list ::= VALUE(a) prop_value_list(b). {
    return [a.toValueString()!] + b
}

//value_type ::= NUMBER | REAL | DOUBLE | COLOR | SIMPLE_TEXT | TEXT | POINT | MOVE | STONE
