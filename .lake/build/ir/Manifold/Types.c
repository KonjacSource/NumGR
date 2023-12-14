// Lean compiler output
// Module: Manifold.Types
// Imports: Init Mathlib Manifold.Tensor
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
LEAN_EXPORT lean_object* l_RieManifold_geodesicPredict___default(lean_object*, lean_object*, lean_object*, lean_object*);
extern uint8_t l_instDecidableTrue;
static lean_object* l_instToStringRay___rarg___closed__1;
LEAN_EXPORT lean_object* l_RieManifold_connect___default(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__3(lean_object*);
LEAN_EXPORT lean_object* l_instToStringVector___boxed(lean_object*, lean_object*);
static lean_object* l_Cartesian_instManifoldCartesianFloat___closed__4;
lean_object* l_List_toString___rarg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___boxed(lean_object*);
static lean_object* l_Cartesian_instManifoldCartesianFloat___closed__1;
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__4___boxed(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_RieManifold_connect___default___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__4(lean_object*, lean_object*);
lean_object* lean_sorry(uint8_t);
LEAN_EXPORT lean_object* l_instToStringVector(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_RieManifold_connect___default___rarg(lean_object*, lean_object*);
static lean_object* l_Cartesian_instManifoldCartesianFloat___closed__2;
static lean_object* l_instToStringRay___rarg___closed__3;
static lean_object* l_instToStringRay___rarg___closed__2;
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__2___boxed(lean_object*, lean_object*);
static lean_object* l_Cartesian_instManifoldCartesianFloat___closed__3;
LEAN_EXPORT lean_object* l_RieManifold_geodesicPredict___default___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat(lean_object*);
LEAN_EXPORT uint8_t l_Cartesian_instManifoldCartesianFloat___lambda__1(lean_object*);
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__1___boxed(lean_object*);
LEAN_EXPORT lean_object* l_instToStringTensor___boxed(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instToStringVector___rarg(lean_object*, lean_object*);
LEAN_EXPORT uint8_t l_Cartesian_instManifoldCartesianFloat___lambda__2(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instToStringRay(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
lean_object* lean_string_append(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instToStringTensor(lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instToStringRay___boxed(lean_object*, lean_object*, lean_object*, lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instToStringRay___rarg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_RieManifold_geodesicPredict___default___rarg(lean_object*, lean_object*);
LEAN_EXPORT lean_object* l_instToStringVector___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_List_toString___rarg(x_1, x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_instToStringVector(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_closure((void*)(l_instToStringVector___rarg), 2, 0);
return x_3;
}
}
LEAN_EXPORT lean_object* l_instToStringVector___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_instToStringVector(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_instToStringTensor(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
uint8_t x_5; lean_object* x_6; 
x_5 = 0;
x_6 = lean_sorry(x_5);
return x_6;
}
}
LEAN_EXPORT lean_object* l_instToStringTensor___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_instToStringTensor(x_1, x_2, x_3, x_4);
lean_dec(x_4);
lean_dec(x_3);
lean_dec(x_2);
return x_5;
}
}
static lean_object* _init_l_instToStringRay___rarg___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_from_bytes("Ray - from ", 11);
return x_1;
}
}
static lean_object* _init_l_instToStringRay___rarg___closed__2() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_from_bytes(" toward ", 8);
return x_1;
}
}
static lean_object* _init_l_instToStringRay___rarg___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_mk_string_from_bytes(" - ", 3);
return x_1;
}
}
LEAN_EXPORT lean_object* l_instToStringRay___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; lean_object* x_4; lean_object* x_5; uint8_t x_6; lean_object* x_7; lean_object* x_8; lean_object* x_9; lean_object* x_10; lean_object* x_11; lean_object* x_12; lean_object* x_13; lean_object* x_14; lean_object* x_15; lean_object* x_16; 
x_3 = lean_ctor_get(x_2, 0);
lean_inc(x_3);
x_4 = lean_ctor_get(x_2, 1);
lean_inc(x_4);
lean_dec(x_2);
x_5 = lean_ctor_get(x_3, 0);
lean_inc(x_5);
lean_dec(x_3);
x_6 = 0;
x_7 = lean_sorry(x_6);
x_8 = lean_apply_1(x_7, x_4);
x_9 = l_List_toString___rarg(x_1, x_5);
x_10 = l_instToStringRay___rarg___closed__1;
x_11 = lean_string_append(x_10, x_9);
lean_dec(x_9);
x_12 = l_instToStringRay___rarg___closed__2;
x_13 = lean_string_append(x_11, x_12);
x_14 = lean_string_append(x_13, x_8);
lean_dec(x_8);
x_15 = l_instToStringRay___rarg___closed__3;
x_16 = lean_string_append(x_14, x_15);
return x_16;
}
}
LEAN_EXPORT lean_object* l_instToStringRay(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
lean_object* x_6; 
x_6 = lean_alloc_closure((void*)(l_instToStringRay___rarg), 2, 0);
return x_6;
}
}
LEAN_EXPORT lean_object* l_instToStringRay___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4, lean_object* x_5) {
_start:
{
lean_object* x_6; 
x_6 = l_instToStringRay(x_1, x_2, x_3, x_4, x_5);
lean_dec(x_5);
lean_dec(x_4);
lean_dec(x_3);
return x_6;
}
}
LEAN_EXPORT lean_object* l_RieManifold_connect___default___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; lean_object* x_5; 
x_3 = 0;
x_4 = lean_sorry(x_3);
x_5 = lean_apply_2(x_4, x_1, x_2);
return x_5;
}
}
LEAN_EXPORT lean_object* l_RieManifold_connect___default(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lean_alloc_closure((void*)(l_RieManifold_connect___default___rarg), 2, 0);
return x_5;
}
}
LEAN_EXPORT lean_object* l_RieManifold_connect___default___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_RieManifold_connect___default(x_1, x_2, x_3, x_4);
lean_dec(x_4);
lean_dec(x_3);
return x_5;
}
}
LEAN_EXPORT lean_object* l_RieManifold_geodesicPredict___default___rarg(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; lean_object* x_5; 
x_3 = 0;
x_4 = lean_sorry(x_3);
x_5 = lean_apply_2(x_4, x_1, x_2);
return x_5;
}
}
LEAN_EXPORT lean_object* l_RieManifold_geodesicPredict___default(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = lean_alloc_closure((void*)(l_RieManifold_geodesicPredict___default___rarg), 2, 0);
return x_5;
}
}
LEAN_EXPORT lean_object* l_RieManifold_geodesicPredict___default___boxed(lean_object* x_1, lean_object* x_2, lean_object* x_3, lean_object* x_4) {
_start:
{
lean_object* x_5; 
x_5 = l_RieManifold_geodesicPredict___default(x_1, x_2, x_3, x_4);
lean_dec(x_4);
lean_dec(x_3);
return x_5;
}
}
LEAN_EXPORT uint8_t l_Cartesian_instManifoldCartesianFloat___lambda__1(lean_object* x_1) {
_start:
{
uint8_t x_2; 
x_2 = l_instDecidableTrue;
return x_2;
}
}
LEAN_EXPORT uint8_t l_Cartesian_instManifoldCartesianFloat___lambda__2(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; 
x_3 = l_instDecidableTrue;
return x_3;
}
}
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__3(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_2, 0, x_1);
return x_2;
}
}
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__4(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = lean_alloc_ctor(1, 1, 0);
lean_ctor_set(x_3, 0, x_1);
return x_3;
}
}
static lean_object* _init_l_Cartesian_instManifoldCartesianFloat___closed__1() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Cartesian_instManifoldCartesianFloat___lambda__1___boxed), 1, 0);
return x_1;
}
}
static lean_object* _init_l_Cartesian_instManifoldCartesianFloat___closed__2() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Cartesian_instManifoldCartesianFloat___lambda__2___boxed), 2, 0);
return x_1;
}
}
static lean_object* _init_l_Cartesian_instManifoldCartesianFloat___closed__3() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Cartesian_instManifoldCartesianFloat___lambda__3), 1, 0);
return x_1;
}
}
static lean_object* _init_l_Cartesian_instManifoldCartesianFloat___closed__4() {
_start:
{
lean_object* x_1; 
x_1 = lean_alloc_closure((void*)(l_Cartesian_instManifoldCartesianFloat___lambda__4___boxed), 2, 0);
return x_1;
}
}
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat(lean_object* x_1) {
_start:
{
lean_object* x_2; lean_object* x_3; lean_object* x_4; lean_object* x_5; lean_object* x_6; 
x_2 = l_Cartesian_instManifoldCartesianFloat___closed__1;
x_3 = l_Cartesian_instManifoldCartesianFloat___closed__2;
x_4 = l_Cartesian_instManifoldCartesianFloat___closed__3;
x_5 = l_Cartesian_instManifoldCartesianFloat___closed__4;
x_6 = lean_alloc_ctor(0, 4, 0);
lean_ctor_set(x_6, 0, x_2);
lean_ctor_set(x_6, 1, x_3);
lean_ctor_set(x_6, 2, x_4);
lean_ctor_set(x_6, 3, x_5);
return x_6;
}
}
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__1___boxed(lean_object* x_1) {
_start:
{
uint8_t x_2; lean_object* x_3; 
x_2 = l_Cartesian_instManifoldCartesianFloat___lambda__1(x_1);
lean_dec(x_1);
x_3 = lean_box(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__2___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
uint8_t x_3; lean_object* x_4; 
x_3 = l_Cartesian_instManifoldCartesianFloat___lambda__2(x_1, x_2);
lean_dec(x_2);
lean_dec(x_1);
x_4 = lean_box(x_3);
return x_4;
}
}
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___lambda__4___boxed(lean_object* x_1, lean_object* x_2) {
_start:
{
lean_object* x_3; 
x_3 = l_Cartesian_instManifoldCartesianFloat___lambda__4(x_1, x_2);
lean_dec(x_2);
return x_3;
}
}
LEAN_EXPORT lean_object* l_Cartesian_instManifoldCartesianFloat___boxed(lean_object* x_1) {
_start:
{
lean_object* x_2; 
x_2 = l_Cartesian_instManifoldCartesianFloat(x_1);
lean_dec(x_1);
return x_2;
}
}
lean_object* initialize_Init(uint8_t builtin, lean_object*);
lean_object* initialize_Mathlib(uint8_t builtin, lean_object*);
lean_object* initialize_Manifold_Tensor(uint8_t builtin, lean_object*);
static bool _G_initialized = false;
LEAN_EXPORT lean_object* initialize_Manifold_Types(uint8_t builtin, lean_object* w) {
lean_object * res;
if (_G_initialized) return lean_io_result_mk_ok(lean_box(0));
_G_initialized = true;
res = initialize_Init(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Mathlib(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
res = initialize_Manifold_Tensor(builtin, lean_io_mk_world());
if (lean_io_result_is_error(res)) return res;
lean_dec_ref(res);
l_instToStringRay___rarg___closed__1 = _init_l_instToStringRay___rarg___closed__1();
lean_mark_persistent(l_instToStringRay___rarg___closed__1);
l_instToStringRay___rarg___closed__2 = _init_l_instToStringRay___rarg___closed__2();
lean_mark_persistent(l_instToStringRay___rarg___closed__2);
l_instToStringRay___rarg___closed__3 = _init_l_instToStringRay___rarg___closed__3();
lean_mark_persistent(l_instToStringRay___rarg___closed__3);
l_Cartesian_instManifoldCartesianFloat___closed__1 = _init_l_Cartesian_instManifoldCartesianFloat___closed__1();
lean_mark_persistent(l_Cartesian_instManifoldCartesianFloat___closed__1);
l_Cartesian_instManifoldCartesianFloat___closed__2 = _init_l_Cartesian_instManifoldCartesianFloat___closed__2();
lean_mark_persistent(l_Cartesian_instManifoldCartesianFloat___closed__2);
l_Cartesian_instManifoldCartesianFloat___closed__3 = _init_l_Cartesian_instManifoldCartesianFloat___closed__3();
lean_mark_persistent(l_Cartesian_instManifoldCartesianFloat___closed__3);
l_Cartesian_instManifoldCartesianFloat___closed__4 = _init_l_Cartesian_instManifoldCartesianFloat___closed__4();
lean_mark_persistent(l_Cartesian_instManifoldCartesianFloat___closed__4);
return lean_io_result_mk_ok(lean_box(0));
}
#ifdef __cplusplus
}
#endif
