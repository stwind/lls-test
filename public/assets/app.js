var statusElm = $('.status');
var infoElm = $('.info');
var loginElm = $('.login');

apiStats(showStats(infoElm));
showStatusVisitor(statusElm);
showLoginForm(loginElm);

function showLoginForm(parent) {
  var content = '<form id="loginForm">' +
      '<input type="text" name="username" placeholder="username" />' +
      '<input type="password" name="password" placeholder="password" />' +
      '<button>登录或注册</button>' +
    '</form>';
  parent.html(content);
}

function hideLoginForm(parent) {
  parent.remove();
}

function showStatusVisitor(parent) {
  var content = '你好，游客。请登录或注册。';
  parent.html(content);
}

function showStatusUser(data, parent) {
  var content = data.username + ' 谢谢你登录了我们网站！你已经登录了 ' + data['login_times'] + ' 次了，';
  parent.html(content);
}

function showStatusLoginFail(parent) {
  var content = '密码错误，请重试。';
  parent.html(content);
}


function showStats(parent) {
  return function (data) {
    var content = '当前用户数：' + data.user;
    parent.html(content);
  };
}

function apiStats(done) {
  $.ajax({
    url: '/api/stats',
    statusCode: {
      200: done
    }
  });
}

function apiRegister(args, done) {
  $.ajax({
    url: '/api/register',
    method: 'POST',
    dataType: 'json',
    data: args,
    statusCode: {
      201: done
    }
  });
}

function apiLogin(args, success, notfound, fail) {
  $.ajax({
    url: '/api/login',
    method: 'POST',
    dataType: 'json',
    data: args,
    statusCode: {
      201: success,
      401: fail,
      404: notfound
    }
  });
}

$('#loginForm').on('submit', function (e) {
  e.preventDefault();

  var username = $('#loginForm').find('input[name="username"]').val();
  var password = $('#loginForm').find('input[name="password"]').val();

  var args = { username: username, password: password };

  apiLogin(args, function (result) {
    console.log('login success');

    hideLoginForm(loginElm);
    apiStats(showStats(infoElm));
    showStatusUser(result.data, statusElm);
  }, function () {
    console.log('login faield, register new');

    apiRegister(args, function (result) {
      console.log('register success');

      hideLoginForm(loginElm);
      apiStats(showStats(infoElm));
      showStatusUser(result.data, statusElm);
    })
  }, function () {
    showStatusLoginFail(statusElm);
  });
});
