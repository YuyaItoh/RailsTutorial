module SessionsHelper
  def sign_in(user)
    remember_token = User.new_remember_token
    # cookiesに保存し，ブラウザに保存させる
    cookies.permanent[:remember_token] = remember_token
    # DBに保存
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  def current_user=(user)
    @current_user = user
  end

  # 毎回のリクエスト（ページ遷移）毎に呼ばれる
  # current_user=が呼ばれるのはサインインの時だけ
  # 従来のようにgetterで@current_userを返しても意味がない
  # DBからremember_tokenを取得する必要がある
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    
    # @current_userがあればそれを返し，無ければDBから取得
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  # 現在のユーザとリクエスト対象のユーザが一致しているか判定
  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      # リクエストされたurlを保存しておく
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def signed_in?
    !current_user.nil?
  end

  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end

  # フレンドリーフォワーディング

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end
end
