var statsElm = $('#stats');
var infoElm = $('#info');
var formElm = $('#form');

apiGetUserInfo(function (result) {
  if (result.id == 0) {
    showInfoVisitor(result);
    showForm();
  } else {
    showInfoUser(result);
  }

  connect();
  updateStats();
});

function showForm() {
  var content = '<form id="loginForm">' +
      '<input type="text" name="username" placeholder="username" />' +
      '<input type="password" name="password" placeholder="password" />' +
      '<button>登录或注册</button>' +
    '</form>';
  formElm.html(content);
  activateForm();
}

function hideForm() {
  formElm.remove();
}

function showInfoVisitor(data) {
  var content = '你好，陌生人。你没有登录，或者你还没有注册，但是你已经浏览这个页面 '+data['online_time']+' 分钟了。';
  infoElm.html(content);
}

function showInfoUser(data) {
  var content = data.username + ' 谢谢你登录了我们网站！你已经登录了 ' + data['login_times'] + ' 次了，总共登录时间是 '+data['online_time']+' 分钟';
  infoElm.html(content);
}

function showInfoLoginFail() {
  var content = '密码错误，请重试。';
  infoElm.html(content);
}

function updateStats() {
  apiGetStats(function (data) {
    showStats(data);
  });
}

function showStats(data) {
  var content = '现在总共有 '+data.user+' 个注册用户在查看这个网站，有 '+data.visitor+' 个陌生人在查看这个网站。';
  statsElm.html(content);
}

function apiGetStats(done) {
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

function apiGetUserInfo(success) {
  $.ajax({
    url: '/api/user/me',
    method: 'GET',
    statusCode: {
      200: success
    }
  });
}

function activateForm() {

  function loginOrRegSuccess (data) {
    hideForm();
    updateStats();
    showInfoUser(data);
  }

  $('#loginForm').on('submit', function (e) {
    e.preventDefault();

    var username = $('#loginForm').find('input[name="username"]').val();
    var password = $('#loginForm').find('input[name="password"]').val();

    var args = { username: username, password: password };

    apiLogin(args, function (result) {
      console.log('login success');
      loginOrRegSuccess(result.data);
    }, function () {
      console.log('login faield, register new');

      apiRegister(args, function (result) {
        console.log('register success');
        loginOrRegSuccess(result.data);
      })
    }, function () {
      $('#loginForm').find('input[name="username"]').val('');
      $('#loginForm').find('input[name="password"]').val('');
      showInfoLoginFail();
    });
  });
}

function connect () {
  var Socket = window.MozWebSocket || window.WebSocket,
    socket = new Socket('ws://' + location.hostname + ':' + location.port + '/eventsource');

  socket.addEventListener('open', function() {
    console.log('SOCKET OPEN: ' + socket.protocol);
  });

  socket.onerror = function(event) {
    console.log('SOCKET ERROR: ' + event.message);
  };

  socket.onclose = function(event) {
    console.log('SOCKET CLOSE: ' + event.code + ', ' + event.reason);
  };
}
