# language: zh-TW

功能: 管理文章
  為了分亨我的見解
  作為一名部落格作者
  我要公布一篇文作

  背景:
    假設 選用 中文
    而且 我是一位登記用戶電郵地址是"peter@example.com"
    而且 我已使用電郵地址"peter@example.com"登入系統

  場景: 上載新文章
    假設 我來到新文章網頁
    當 我在"標題"欄位中輸入"Hello world"
    而且 在"內文"欄位中輸入"Have a nice day"
    而且 在"發表日期"欄位中輸入"2010-07-01"
    而且 按下了"建立 文章"按钮
    那麼 我應該看到"Hello world"的提示信息
    而且 我應該看到"Have a nice day"
    而且 我應該看到"2010-07-01"

  場景: 查看文章列表
    假設 系統己存下列文章:
      |title|body|published_on|
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 3|body 3|2010-07-03|
      |title 4|body 4|2010-07-04|
    當 我瀏覽網頁"/posts"
    那麼 我看到一個文章列表
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 3|body 3|2010-07-03|
      |title 4|body 4|2010-07-04|
    那麼 顯示完整網頁

  # Rails generates Delete links that use Javascript to pop up a confirmation
  # dialog and then do a HTTP POST request (emulated DELETE request).
  #
  # Capybara must use Culerity/Celerity or Selenium2 (webdriver) when pages rely
  # on Javascript events. Only Culerity/Celerity supports clicking on confirmation
  # dialogs.
  #
  # Since Culerity/Celerity and Selenium2 has some overhead, Cucumber-Rails will
  # detect the presence of Javascript behind Delete links and issue a DELETE request
  # instead of a GET request.
  #
  # You can turn this emulation off by tagging your scenario with @no-js-emulation.
  # Turning on browser testing with @selenium, @culerity, @celerity or @javascript
  # will also turn off the emulation. (See the Capybara documentation for
  # details about those tags). If any of the browser tags are present, Cucumber-Rails
  # will also turn off transactions and clean the database with DatabaseCleaner
  # after the scenario has finished. This is to prevent data from leaking into
  # the next scenario.
  #
  # Another way to avoid Cucumber-Rails'' javascript emulation without using any
  # of the tags above is to modify your views to use <button> instead. You can
  # see how in http://github.com/jnicklas/capybara/issues#issue/12
  #

  場景: Delete post
    假設 系統己存下列文章:
      |title|body|published_on|
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 3|body 3|2010-07-03|
      |title 4|body 4|2010-07-04|
    當 我刪除第3個文章
    那麼 我看到一個文章列表
      |title 1|body 1|2010-07-01|
      |title 2|body 2|2010-07-02|
      |title 4|body 4|2010-07-04|

