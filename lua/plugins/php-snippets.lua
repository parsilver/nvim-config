-- php-snippets.lua
-- PHP and Laravel snippets for LuaSnip

return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    config = function(_, opts)
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node
      local f = ls.function_node
      local c = ls.choice_node
      local d = ls.dynamic_node
      local fmt = require("luasnip.extras.fmt").fmt
      
      -- Load existing snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      -- Add PHP snippets
      ls.add_snippets("php", {
        -- PHP Class
        s("class", fmt([[
          <?php
          
          namespace {};
          
          class {} {}
          {}
        ]], {
          i(1, "App\\"),
          i(2, "ClassName"),
          i(3, ""),
          i(0),
        })),
        
        -- PHP Function
        s("fn", fmt([[
          /**
           * {}
           */
          public function {}({}){}
          {{
              {}
          }}
        ]], {
          i(1, "Function description"),
          i(2, "functionName"),
          i(3, ""),
          c(4, {
            t(": void"),
            t(": string"),
            t(": array"),
            t(": bool"),
            t(": int"),
            t(": float"),
            t(": object"),
            t(""),
          }),
          i(0, "// Code here"),
        })),
        
        -- PHP Constructor
        s("construct", fmt([[
          /**
           * Create a new {} instance.
           */
          public function __construct({})
          {{
              {}
          }}
        ]], {
          i(1, "class"),
          i(2, ""),
          i(0, "// Constructor code"),
        })),
        
        -- PHP Interface
        s("interface", fmt([[
          <?php
          
          namespace {};
          
          interface {}
          {{
              {}
          }}
        ]], {
          i(1, "App\\Interfaces"),
          i(2, "InterfaceName"),
          i(0, "// Interface methods"),
        })),
        
        -- PHP Trait
        s("trait", fmt([[
          <?php
          
          namespace {};
          
          trait {}
          {{
              {}
          }}
        ]], {
          i(1, "App\\Traits"),
          i(2, "TraitName"),
          i(0, "// Trait methods"),
        })),
      })
      
      -- Add Laravel-specific snippets
      ls.add_snippets("php", {
        -- Laravel Controller
        s("controller", fmt([[
          <?php
          
          namespace App\Http\Controllers;
          
          use Illuminate\Http\Request;
          
          class {}Controller extends Controller
          {{
              /**
               * Display a listing of the resource.
               */
              public function index()
              {{
                  {}
              }}
          
              /**
               * Show the form for creating a new resource.
               */
              public function create()
              {{
                  {}
              }}
          
              /**
               * Store a newly created resource in storage.
               */
              public function store(Request $request)
              {{
                  {}
              }}
          
              /**
               * Display the specified resource.
               */
              public function show(${})
              {{
                  {}
              }}
          
              /**
               * Show the form for editing the specified resource.
               */
              public function edit(${})
              {{
                  {}
              }}
          
              /**
               * Update the specified resource in storage.
               */
              public function update(Request $request, ${})
              {{
                  {}
              }}
          
              /**
               * Remove the specified resource from storage.
               */
              public function destroy(${})
              {{
                  {}
              }}
          }}
        ]], {
          i(1, "Resource"),
          i(2, "// Index code"),
          i(3, "// Create code"),
          i(4, "// Store code"),
          i(5, "model"),
          i(6, "// Show code"),
          i(7, "model"),
          i(8, "// Edit code"),
          i(9, "model"),
          i(10, "// Update code"),
          i(11, "model"),
          i(0, "// Destroy code"),
        })),
        
        -- Laravel Model
        s("model", fmt([[
          <?php
          
          namespace App\Models;
          
          use Illuminate\Database\Eloquent\Factories\HasFactory;
          use Illuminate\Database\Eloquent\Model;
          
          class {} extends Model
          {{
              use HasFactory;
              
              /**
               * The attributes that are mass assignable.
               *
               * @var array
               */
              protected $fillable = [
                  {}
              ];
              
              {}
          }}
        ]], {
          i(1, "ModelName"),
          i(2, "'name', 'email', 'password'"),
          i(0, "// Model relationships and methods"),
        })),
        
        -- Laravel Migration
        s("migration", fmt([[
          <?php
          
          use Illuminate\Database\Migrations\Migration;
          use Illuminate\Database\Schema\Blueprint;
          use Illuminate\Support\Facades\Schema;
          
          return new class extends Migration
          {{
              /**
               * Run the migrations.
               */
              public function up(): void
              {{
                  Schema::create('{}', function (Blueprint $table) {{
                      $table->id();
                      {}
                      $table->timestamps();
                  }});
              }}
          
              /**
               * Reverse the migrations.
               */
              public function down(): void
              {{
                  Schema::dropIfExists('{}');
              }}
          }};
        ]], {
          i(1, "table_name"),
          i(2, "$table->string('name');"),
          f(function(args) return args[1][1] end, {1}),
        })),
      })
      
      -- Add Blade snippets
      ls.add_snippets("blade", {
        -- Blade Section
        s("section", fmt([[
          @section('{}')
              {}
          @endsection
        ]], {
          i(1, "content"),
          i(0, "// Section content"),
        })),
        
        -- Blade Extends
        s("extends", fmt([[
          @extends('{}')
          
          {}
        ]], {
          i(1, "layouts.app"),
          i(0),
        })),
        
        -- Blade Include
        s("include", fmt([[
          @include('{}'{})
        ]], {
          i(1, "partial"),
          c(2, {
            t(""),
            fmt(", [{}]", {i(1, "'key' => 'value'")}),
          }),
        })),
        
        -- Blade If Statement
        s("if", fmt([[
          @if ({})
              {}
          @endif
        ]], {
          i(1, "condition"),
          i(0, "// If content"),
        })),
        
        -- Blade If-Else Statement
        s("ifelse", fmt([[
          @if ({})
              {}
          @else
              {}
          @endif
        ]], {
          i(1, "condition"),
          i(2, "// If content"),
          i(0, "// Else content"),
        })),
        
        -- Blade Foreach Loop
        s("foreach", fmt([[
          @foreach ({} as {})
              {}
          @endforeach
        ]], {
          i(1, "$items"),
          i(2, "$item"),
          i(0, "// Loop content"),
        })),
        
        -- Blade Form
        s("form", fmt([[
          <form method="{}" action="{}"{}> 
              @csrf
              {}
              <button type="submit">{}</button>
          </form>
        ]], {
          c(1, {t("POST"), t("GET"), t("PUT"), t("DELETE")}),
          i(2, "{{ route('route.name') }}"),
          c(3, {
            t(""),
            t(" enctype=\"multipart/form-data\""),
          }),
          i(4, "// Form fields"),
          i(0, "Submit"),
        })),
      })
    end,
  },
} 