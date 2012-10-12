What?
=====

A yaml backend for Hiera that will merge hashes by using the
excelent deep_merge. This module is basicly just a dirty hack from the original yaml module.

Usage?
======

This backend can be used as an replacement of the default Hiera yaml backend, while the default yaml backend overwrites (commplate) hashes this module tries to merge them together.

add this backend to the hiera configfile:

<pre>
:backends:
  - dyml

:hierarchy:
   - adhoc
   - %{hostname}
   - default/%{calling_module}

:dyml:
  :datadir: /usr/local/etc/pupdata/yaml
</pre>

You can use the same file extention as the default yaml backend (and even the same files)

Example:
in the default yaml file from the resolv module you have set the default dns settings like this:

<pre>
resolv:
  domain: bla.nl
  nameservers:
    - 10.0.0.1
    - 10.0.0.2
</pre>

which might the fine for most of your zillion servers, but on a few others you want to set the domain to bladiebla.nl with the default yaml backend you will have to add the nameservers in the host overwrite as well not realy DRY, with the dyml backend you can just overwrite the changed entries like this:

<pre>
resolv:
  domain: bladiebla.nl
</pre>

Who?
====

Johan Bakker / johan.bakker@panifex.nl / @panifexnl
Gregory Becker / @igreg [some fixes]
