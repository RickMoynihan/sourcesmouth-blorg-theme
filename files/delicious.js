function showImage( img ){ return (function(){ img.style.display='inline'; }) }

var ul = document.createElement('ul')
for (var i=0, post; post = Delicious.posts[i]; i++) {
    var li = document.createElement('li')
    var a = document.createElement('a')
    //a.style.marginLeft = '20px'
    //var img = document.createElement('img')
    //img.style.position = 'absolute'
    //img.style.display = 'none'
    //img.height = img.width = 16
    //img.src = post.u.split('/').splice(0,3).join('/')+'/favicon.ico'
    //img.onload = showImage(img);
    a.setAttribute('href', post.u)
    a.appendChild(document.createTextNode(post.d))
    //li.appendChild(img)
    li.appendChild(a)
    ul.appendChild(li)
    ul.setAttribute('class','navigation')
}
document.getElementById('container').appendChild(ul)