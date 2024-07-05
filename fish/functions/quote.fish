function quote --wraps=quote --description 'alias quote=quote'
    clear

    set json (curl -s "https://api.quotable.io/random")
    set quote (echo $json | jq -r '.content')
    set author (echo $json | jq -r '.author')
    echo
    set_color yellow
    echo $quote
    set_color normal
    echo - $author
end
