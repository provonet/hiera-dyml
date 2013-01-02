What?
=====

A yaml backend for Hiera that will merge hashes by using the
excelent deep_merge gem.

Usage?
======

This backend can be used as a replacement for default Hiera yaml backend, while the default yaml backend overwrites (commplate) hashes this module tries to merge them together.

add this backend to the hiera configfile:

<pre>
:backends:
  - dyml

:hierarchy:
   - %{hostname}
   - default

:dyml:
  :datadir: .
</pre>

You can use the same file extention as the default yaml backend (and even the same files)

Example:
in the default yaml file from the resolv module you can set the default dns settings like this:

<pre>
resolv:
  domain: example.com 
  nameservers:
    - 10.0.0.1
    - 10.0.0.2
</pre>

which might be ok for 99.9% of your servers, but if you want to set the 0.1% of your servers to foo.example.com you will have to overwrite the complete hash with the default yaml backend, with the dyml backend you can just overwrite parts of the hash by using the deep_merge gem module:

<pre>
resolv:
  domain: foo.example.com 
</pre>

Who?
====

Johan Bakker / johan.bakker@panifex.nl / @panifexnl
Gregory Becker / @igreg [some fixes]
Wayne Zhang / @hopecream [Reporting conflicts with ActiveSupport]
