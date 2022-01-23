function output_line() {
    local spacing="      "
    echo "$spacing $1"
}

function output_section() {
    local indentation="----->"
    echo "$indentation $1"
}

function clean_cache() {
    output_section "Cleaning cache"
    rm -rf $cache_path/*
}
