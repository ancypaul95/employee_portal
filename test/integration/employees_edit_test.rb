require 'test_helper'

class EmployeesEditTest < ActionDispatch::IntegrationTest
  def setup
    @employee = employees(:example)
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
                                          :provider => 'facebook',
                                          :uid => '123545',
                                          :info => {
                                              :name => ' Example',
                                              :email => 'example@gmail.com',
                                              :birthday => '01/10/1995',
                                              :hometown => {
                                                :name =>'Muvattupzha,India'
                                              },
                                              :location => {
                                                :name =>'Muvattupuzha,India'
                                              },
                                              :posts => {
                                                :data => [
                                                  :story => 'aasdfghjklqwertyuizxcvbnm,sdfghjk'
                                                ]
                                              },
                                              :picture => {
                                                :data => {
                                                  :url => 'https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/24232151_868902676611680_8286081242403745265_n.jpg?oh=9bbb9ad2d8e23be229bda4d99a7ef185&oe=5AE5D586'
                                                }
                                              }
                                            },
                                            :credentials => {
                                              token: 'EAACQocJY0vUBAPTCE6GQGuQrJqmyvN78pQZBjkWs2HFjH6pnD3AkSq64N2M7ZACQaZADHeyzGhoQJNdqSuc47AydMdyfJmXrHo4ypvwCP3eYJcpf5AJzMKbI7zh0vKdOIHVXM3eU8LeWo5EQz776cDUHIVbZAgqfGfMsmLswFDMv0AR8WE84LfFLtl1W0sQZD',
                                              secret: 'ea0245ec077f79112a5be084ce5690bd'
                                            }
                                        })
  end

  test "unsuccessful edit" do    
    get login_path
    post login_path, params: { session: { email:    @employee.email,
                                          password: 'password' } }
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    assert_select 'a[href=?]',auth_provider_path
    get auth_provider_path
    assert_redirected_to auth_facebook_callback_path
    patch employee_path(@employee), params: { employee: { 
                                              email: "foo@invalid",
                                              designation:"foo",
                                              dateofjoin:"qwe",
                                              dateofbirth:"tyu",
                                              personalemail:"foo@invalid",
                                              username:"user" } }
 
    assert @employee
  end

  test "successful edit" do  
    get login_path
    post login_path, params: { session: { email:    @employee.email,
                                          password: 'password' } }
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    email = "foo@bar.com"
    designation="developer",
    dateofjoin="12/11/2017",
    dateofbirth="10/12/1994",
    personalemail="foo@bar.com"
    username="foobar"
    patch employee_path(@employee), params: { employee: { 
                                              email: email,
                                              designation:designation,
                                              dateofjoin:dateofjoin,
                                              dateofbirth:dateofbirth,
                                              personalemail:personalemail,
                                              username:username } }
    assert_not flash.empty?
    assert_redirected_to home_path
    @employee.reload 
  end

  test "invalid details from facebook" do
    stub_request(:get, /https:\/\/graph\.facebook.com\/v2\.0\/me\?(access_token=[A-Za-z0-9]*&)?fields=picture,name,email,birthday/).
    with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.12.2'}).
    to_return(status: 200, body: {}.to_json, headers: {})
    get login_path
    post login_path, params: { session: { email:    @employee.email,
                                          password: 'password' } }
    
    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    assert_select 'a[href=?]',auth_provider_path
    get auth_provider_path
    assert_redirected_to auth_facebook_callback_path
    follow_redirect!
    assert_template 'employees/edit'
  end

  test "valid details from facebook" do
    stub_request(:get, /https:\/\/graph\.facebook.com\/v2\.0\/me\?(access_token=[A-Za-z0-9]*&)?fields=picture,name,email,birthday/).
    with(headers: {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.12.2'}).
    to_return(status: 200, body: {name: 'Example',email: 'example@gmail.com',birthday: '01/10/1995',hometown: 'Muvattupzha,India',
                                  location: 'Muvattupuzha,India',
                                  posts: {data: [{story: 'aasdfghjklqwertyuizxcvbnm,sdfghjk'}]},
                                  picture: {data: {url: 'https://scontent.xx.fbcdn.net/v/t1.0-1/p50x50/24232151_868902676611680_8286081242403745265_n.jpg?oh=9bbb9ad2d8e23be229bda4d99a7ef185&oe=5AE5D586'}}}.to_json, headers: {})
    get login_path
    post login_path, params: { session: { email:    @employee.email,
                                          password: 'password' } }

    get edit_employee_path(@employee)
    assert_template 'employees/edit'
    assert_select 'a[href=?]',auth_provider_path
    get auth_provider_path
    assert_redirected_to auth_facebook_callback_path
    follow_redirect!
    assert_template 'employees/edit'
  end
end