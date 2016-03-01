require_relative "./_configure"

DB.define_table("users")
DB.define_column("users", "name", "string")
DB.define_column("users", "email", "string")
DB.define_column("users", "password", "string")

DB.define_table("pledges")
DB.define_column("pledges", "user_id", "integer")
DB.define_column("pledges", "gift_id", "integer")
DB.define_column("pledges", "amount", "float")

DB.define_table("gifts")
DB.define_column("gifts", "user_id", "integer")
DB.define_column("gifts", "title", "string")
DB.define_column("gifts", "description", "text")
DB.define_column("gifts", "link", "string")
DB.define_column("gifts", "recipient", "string")
DB.define_column("gifts", "cost", "float")
DB.define_column("gifts", "funded", "boolean")