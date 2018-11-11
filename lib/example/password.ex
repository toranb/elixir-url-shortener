defmodule Example.Password do
  import Bcrypt, only: [hash_pwd_salt: 1]

  def hash(password) do
    hash_pwd_salt(password)
  end
end
