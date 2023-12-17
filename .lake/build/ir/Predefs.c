// Lean compiler output
// Module: Predefs
// Imports: Init
#include <lean/lean.h>
#if defined(__clang__)
#pragma clang diagnostic ignored "-Wunused-parameter"
#pragma clang diagnostic ignored "-Wunused-label"
#elif defined(__GNUC__) && !defined(__CLANG__)
#pragma GCC diagnostic ignored "-Wunused-parameter"
#pragma GCC diagnostic ignored "-Wunused-label"
#pragma GCC diagnostic ignored "-Wunused-but-set-variable"
#endif
#ifdef __cplusplus
extern "C" {
#endif
LEAN_EXPORT lean_object* l_Vector_length(lean_object*);
LEAN_EXPORT lean_object* l_Vector_instDecidableEqVector___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_get(lean_object*, lean_object*);
uint8_t l_List_hasDecEq___rarg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat__1___rarg___boxed(lean_object*);
LEAN_EXPORT lean_object* l_List_sum(lean_object*);
lean_object* l_List_get___rarg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_tail___rarg(lean_object*);
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat___rarg___boxed(lean_object*);
LEAN_EXPORT lean_object* l_Vector_get___rarg(lean_object*, lean_object*);
lean_object* l_List_appendTR___rarg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_head___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_toList___rarg___boxed(lean_object*);
LEAN_EXPORT lean_object* l_Vector_get___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_List_sum___rarg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_head___rarg___boxed(lean_object*);
LEAN_EXPORT lean_object* l_Vector_append(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_get___rarg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_instDecidableEqVector___rarg___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_head___rarg(lean_object*);
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat__1(lean_object*);
LEAN_EXPORT lean_object* l_Vector_length___rarg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat(lean_object*);
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat__1___rarg(lean_object*);
LEAN_EXPORT lean_object* l_Vector_toList___boxed(lean_object*, lean_object*);
LEAN_EXPORT uint8_t l_Vector_instDecidableEqVector___rarg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_toList___rarg(lean_object*);
LEAN_EXPORT lean_object* l_Vector_append___boxed(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_instDecidableEqVector(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_tail___rarg___boxed(lean_object*);
LEAN_EXPORT lean_object* l_Vector_cons(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_tail(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_head(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_List_foldl___at_List_sum___spec__1___rarg(lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_tail___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_nil(lean_object*);
LEAN_EXPORT lean_object* l_Vector_toList(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_List_foldl___at_List_sum___spec__1(lean_object*);
LEAN_EXPORT lean_object* l_Vector_length___rarg___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_cons___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat___rarg(lean_object*);
LEAN_EXPORT lean_object* l_Vector_cons___rarg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Vector_append___rarg(lean_object*, lean_object*);
LEAN_EXPORT uint8_t l_Vector_instDecidableEqVector___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
uint8_t x_4; 
x_4 = l_List_hasDecEq___rarg(x_1, x_2, x_3);
return x_4;
}
}
LEAN_EXPORT lean_object* l_Vector_instDecidableEqVector(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(l_Vector_instDecidableEqVector___rarg___boxed), 3, 0);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_instDecidableEqVector___rarg___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
uint8_t x_4; lean_object* x_5; 
x_4 = l_Vector_instDecidableEqVector___rarg(x_1, x_2, x_3);
x_5 = lean_box(x_4);
return x_5;
}
}
LEAN_EXPORT lean_object* l_Vector_instDecidableEqVector___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_instDecidableEqVector(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_nil(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_box(0);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Vector_cons___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_ctor(1, 2, 0);
lean_ctor_set(x_3, 0, x_1);
lean_ctor_set(x_3, 1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_cons(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(l_Vector_cons___rarg), 2, 0);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_cons___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_cons(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_length___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_inc(x_1);
return x_1;
}
}
LEAN_EXPORT lean_object* l_Vector_length(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_Vector_length___rarg___boxed), 2, 0);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Vector_length___rarg___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_length___rarg(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_head___rarg(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_ctor_get(x_1, 0);
lean_inc(x_2);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Vector_head(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(l_Vector_head___rarg___boxed), 1, 0);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_head___rarg___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_Vector_head___rarg(x_1);
lean_dec(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Vector_head___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_head(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_tail___rarg(lean_object* x_1) {
_start:
{
if (lean_obj_tag(x_1) == 0)
{
lean_object* x_2; 
x_2 = lean_box(0);
return x_2;
}
else
{
lean_object* x_3; 
x_3 = lean_ctor_get(x_1, 1);
lean_inc(x_3);
return x_3;
}
}
}
LEAN_EXPORT lean_object* l_Vector_tail(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(l_Vector_tail___rarg___boxed), 1, 0);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_tail___rarg___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_Vector_tail___rarg(x_1);
lean_dec(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Vector_tail___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_tail(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_toList___rarg(lean_object* x_1) {
_start:
{
lean_inc(x_1);
return x_1;
}
}
LEAN_EXPORT lean_object* l_Vector_toList(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(l_Vector_toList___rarg___boxed), 1, 0);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_toList___rarg___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_Vector_toList___rarg(x_1);
lean_dec(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Vector_toList___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_toList(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_get___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_List_get___rarg(x_1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_get(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(l_Vector_get___rarg___boxed), 2, 0);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_get___rarg___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_get___rarg(x_1, x_2);
lean_dec(x_1);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_get___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Vector_get(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_append___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_List_appendTR___rarg(x_1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Vector_append(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = lean_alloc_closure((void*)(l_Vector_append___rarg), 2, 0);
return x_4;
}
}
LEAN_EXPORT lean_object* l_Vector_append___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l_Vector_append(x_1, x_2, x_3);
lean_dec(x_3);
lean_dec(x_2);
return x_4;
}
}
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat___rarg(lean_object* x_1) {
_start:
{
lean_inc(x_1);
return x_1;
}
}
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_instOfNatOfNatNatInstOfNatNat___rarg___boxed), 1, 0);
return x_2;
}
}
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat___rarg___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_instOfNatOfNatNatInstOfNatNat___rarg(x_1);
lean_dec(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat__1___rarg(lean_object* x_1) {
_start:
{
lean_inc(x_1);
return x_1;
}
}
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_instOfNatOfNatNatInstOfNatNat__1___rarg___boxed), 1, 0);
return x_2;
}
}
LEAN_EXPORT lean_object* l_instOfNatOfNatNatInstOfNatNat__1___rarg___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_instOfNatOfNatNatInstOfNatNat__1___rarg(x_1);
lean_dec(x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_List_foldl___at_List_sum___spec__1___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
if (lean_obj_tag(x_3) == 0)
{
lean_dec(x_1);
return x_2;
}
else
{
lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_4 = lean_ctor_get(x_3, 0);
lean_inc(x_4);
x_5 = lean_ctor_get(x_3, 1);
lean_inc(x_5);
lean_dec(x_3);
lean_inc(x_1);
x_6 = lean_apply_2(x_1, x_2, x_4);
x_2 = x_6;
x_3 = x_5;
goto _start;
}
}
}
LEAN_EXPORT lean_object* l_List_foldl___at_List_sum___spec__1(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_List_foldl___at_List_sum___spec__1___rarg), 3, 0);
return x_2;
}
}
LEAN_EXPORT lean_object* l_List_sum___rarg(lean_object* x_1, lean_object* x_2, lean_object* x_3) {
_start:
{
lean_object* x_4; 
x_4 = l_List_foldl___at_List_sum___spec__1___rarg(x_1, x_2, x_3);
return x_4;
}
}
LEAN_EXPORT lean_object* l_List_sum(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_closure((void*)(l_List_sum___rarg), 3, 0);
return x_2;
}
}
lean_object* initialize_Init(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_Predefs(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
