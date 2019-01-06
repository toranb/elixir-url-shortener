defmodule Example.Password do
  import Bcrypt, only: [hash_pwd_salt: 1, verify_pass: 2]

  def hash(password) do
    hash_pwd_salt(password)
  end

  def verify(password, hash) do
    verify_pass(password, hash)
  end
end
