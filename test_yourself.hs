module DSemImp where

import Debug.Trace
import Test.HUnit 
import Char
import Text.Show.Functions

-- --------------------------------------------	--
-- ---------- Abstract Syntax -----------------	--
type Numeral = Int
type Ident = String

data Command = Skip
               | Assign   (Ident,       Expression)
               | Letin    (Declaration, Command   )
               | Cmdcmd   (Command,     Command   )
               | Ifthen   (Expression,  Command, Command)
               | Whiledo  (Expression,  Command   )
               | Procall  (Ident,       ActualParameter)
               deriving Show

data Expression = Num Numeral
                  | False_
                  | True_
                  | Notexp   Expression
                  | Id       Ident
                  | Sumof   (Expression,  Expression)
                  | Subof   (Expression,  Expression)
                  | Prodof  (Expression,  Expression)
                  | Less    (Expression,  Expression)
                  | Leten   (Declaration, Expression)
                  | Funcall (Ident,       Expression)
                  deriving Show

data Declaration = Constdef  (Ident,  Expression) 
                   | Vardef  (Ident,  TypeDef) 
                   | Funcdef (Ident,  FormalParameter, Expression)
                   | Procdef (Ident,  FormalParameter, Command)
                   deriving Show

data TypeDef = Bool | Int deriving Show

-- --------------------------------------------	--
-- ---------- Semantic Domains ----------------	--

type Integer = Int
type Boolean = Bool
type Location = Int

data Value = 

type Storable = Value
type Argument = Value

type FunctionType   = 
type ProcedureType  =

data Bindable = 

instance Eq Bindable where
  (Procedure p1) == (Procedure p2) = False
  (Function p1) == (Function p2) = False
  (Const v1) == (Const v2) = v1 == v2
  (Variable l1) == (Variable l2) = l1 == l2

data Denotable = 

data FormalParameter = 
data ActualParameter = 

-- --------------------------------------------	--
-- ---------- Semantic Functions --------------	--
valuation     ::
evaluate      ::
elaborate     ::
execute       ::
bindParameter ::
giveArgument  :: 

bindParameter 
giveArgument

-- --------------------------------------------	--
-- ---------- Auxiliary Semantic Functions ----	--
add       (x, y) = x + y
diff      (x, y) = x - y
prod      (x, y) = x * y
lessthan  (x, y) = x < y

-- ---------- Storage   ---------- --
-- fun deallocate sto loc:Location = sto	-- ... later --

data Sval  = 

-- The actual storage in a Store
type DataStore = 

--	                 --bot---   --top---  --data---
data Store = Store (Location,  Location,  DataStore)

update :: (Store, Location, Value) -> Store
update (Store(bot, top, sto), loc, v) =

		-- fetch from store, and convert into Storable (=Const)
fetch :: (Store, Location) -> Storable
fetch  (Store(bot, top, sto), loc)  =

		-- create a new "undefined" location in a store
allocate :: Store -> (Store, Location)
allocate ( Store(bot, top, sto) )  =

-- ---------- Envirionment   ----------
type  Environ  =  

bind :: (Ident, Bindable) -> Environ

-- look through the layered environment bindings
find :: (Environ, Ident) -> Bindable
find  (env, id)  =

overlay :: (Environ, Environ) -> Environ
overlay  (env', env)  =

-- ---------- Etc...
--    coerce a Bindable into a Const..
coerc :: (Store, Bindable) -> Value
coerc (sto, Const v)      = v
coerc (sto, Variable loc) = fetch(sto,loc)

-- ---------- Initialize system  ----------
env_null :: Environ
env_null =  \i -> Unbound

--  store_null =  empty (=0), addressing starts at 1
sto_init :: DataStore
sto_init =  \loc -> Unused

sto_null :: Store
sto_null =  Store( 1, 0, sto_init)

-- --------------------------------------------
-- ---------- Semantic Equations --------------

				-- from integer to Const Value
valuation ( n ) = IntValue(n)

execute ( Skip ) env sto = sto

execute ( Assign(name, exp) ) env sto  =

execute ( Letin(dec, c) ) env sto =

execute ( Cmdcmd(c1, c2) ) env sto  =

execute ( Ifthen(e, c1, c2) ) env sto =
                  
execute ( Whiledo(e, c) ) env sto =

execute (Procall(procName, param)) env sto = 

     			-- simple, just build a Const
evaluate ( Num(n)  )  env sto  = IntValue n
evaluate ( True_   )  env sto  = TruthValue  True
evaluate ( False_  )  env sto  = TruthValue  False

     			-- lookup id, and  coerce as needed
evaluate ( Id(n)  )  env sto  = 

     			-- get Consts, and compute result
evaluate ( Sumof(e1,e2) ) env sto =

evaluate ( Subof(e1,e2) ) env sto =

evaluate ( Prodof(e1,e2) ) env sto =

evaluate ( Less(e1, e2) ) env sto =

evaluate ( Notexp(e) ) env sto = 

evaluate ( Leten(def, e) ) env sto =

evaluate (Funcall(funcName, param)) env sto =  

elaborate ( Constdef(name, e) ) env sto =

elaborate ( Vardef(name, tdef) ) env sto =

elaborate (Funcdef(name, fp, e)) env sto =

elaborate (Procdef(procName, fp, c)) env sto =
