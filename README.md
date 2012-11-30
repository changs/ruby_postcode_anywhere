ruby_postcode_anywhere
======================

Using.

```
PostcodeAnywhere.key = "your key"
query = PostcodeAnywhere.validate_bank_details("12345678", "11-22-33")
query.success?
=> fail

PostcodeAnywhere.lookup("IP13 6QP")
=> #<PostcodeAnywhere::Response:0x007fcc8540c5f0
 @errors={},
 @response=
  [{"Udprn"=>"11615355",
    "Company"=>nil,
    "Department"=>nil,
    "Line1"=>"1 Shop Road",
    "Line2"=>"Clopton",
    ...
```
