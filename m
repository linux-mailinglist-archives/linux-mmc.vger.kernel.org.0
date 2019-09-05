Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D5A1AACAC
	for <lists+linux-mmc@lfdr.de>; Thu,  5 Sep 2019 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbfIEUBn (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 5 Sep 2019 16:01:43 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:39145 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730622AbfIEUBn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 5 Sep 2019 16:01:43 -0400
Received: from localhost ([83.135.64.178]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis) id
 1MCKSA-1hxgTQ3KWg-009QYv; Thu, 05 Sep 2019 22:01:38 +0200
Date:   Thu, 5 Sep 2019 22:01:38 +0200
From:   Tim Schumacher <tim@timakro.de>
To:     linux-mmc@vger.kernel.org
Cc:     pher1989@hotmail.com
Subject: Black screen while resuming a SDXC (UHS) card (_mmc_sd_resume)
Message-ID: <20190905200138.GA19037@impa.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Provags-ID: V03:K1:f5+7HBay9gGtBxlktx9bRvd4DSnuzfHhPjhK0tGYWr7yU8073jc
 P461yhHWjWJV5Y5cKAj/QgLQN+HPMHI5xKCDSCFiSTH5DU24lEXvW4bOs0mEH4YhzIJ3tJ2
 Ldp45E87sqYZ/5Cr0hYMgBwGicccrN7itd/sOb3fCICTn8B2l9XJVd0QszWEar1HH/V30Z1
 +V0pJRbSOt+m7Q1UODfbg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AvKa37S9cQ8=:0TKdk/HVqMaRcgogDA6f5/
 dsf6RMPvJv2+qg2WLlRSH3K70NomTUG8bEpOeciyXEl/iztWdDW41oQuC8YLUOPvAGAvhIBy9
 JywTyJL5pJ4bLZ4Ya502o32HpUOtF4vlAOy9+y4dHxOD1s9VhVXmTxIKhxN4htdptD5FUrKK8
 v0BFAuLRZpfwV51p1+pD0PiRoYTgcJ39EqKJHinZuhiz0BYtsbFh8pcCJKLkQ09Q16VxdVsuE
 vZqdYQ5SutzIrkRdLKMOGruW6s7N/VWlyM84k2CWgRATTj6hbNbrGgjVbw3eHZhJRW6pk3t//
 r10KR65i9bhw26TSGW+BhiJ3DsaIjJoCj/X87zFQ6xYSCidnryjiB4My+nVEpf7obXxCuOxOf
 zKcTnja00HUfdbMfUzbjED843WY1by/TwnFrx9nxngG52afia2abQCqNkqZvVm8O846mQTRgC
 ihNnAvBvLzENCHm4Wo+G8OvBdH3U0bjNllOeVcb08t+U2lwK3dIbcKS3dgHHkL6SX3cUJuEiE
 ttYMlPDu44k56nhgLNPbe92oCwVQ324jUdRD32DAr8CmxpEE2/d8pjDTyHtPX7sX+L/ZbkGwH
 AA28+nJtxnarVFL0Cayb8VGl9VLCBXAwcUEjLZEctZ4gbxGvkStWZv68eF3TKiNJDXYyfcwDX
 R63Sityydy6k/Qz0WPyfn2GkdH4c4vn+Wuomt4PfOT4auy5Y7vUqENMNoaw+aYvlVNK0vO2uf
 EMy68qydCKtqX/jio0UUt+uDkjU0HerZzDID2TR7k0e8kL2NHDc1pH/BwxCfYRG0LIrp2++6q
 DEYLiI5nRTxPCzZjtKJ22r/DcEuVh7S9ITpk0/Io/CzoH9mVck=
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm sending this old bug by mail since a lot of developers don't use
bugzilla.

Original bug report on bugzilla by Pedro Rodrigues from 2019-01-30:

https://bugzilla.kernel.org/show_bug.cgi?id=3D202459

> This bug can be found on a Lenovo Miix 320-10ICR
>=20
> When using a SDXC (UHS) card, the screen becomes black if
> _mmc_sd_resume() is called. After some investigation, I found that an
> UHS card uses 1.8 V for signalling while a normal SD card uses 3.3 V. By
> forcing the SDXC to use 3.3 V the black screen does not appear. It seems
> that during a _mmc_sd_resume function call, while claiming the host, an
> I2C resume function is called based on an existing supplier link between
> the I2C bus and the card device.  The problem is that if the signalling
> voltage is configured to 1.8 V, during the I2C resume call, the screen
> turns black.  I was able to fix this issue by setting the initial signal
> voltage (3.3 V) before suspending the card, so that when the card is
> resumed, the voltage is in the original state. To do this I added a
> function call to mmc_set_initial_signal_voltage() during mmc_power_off
> routine (drivers/mmc/core/core.c).  As I=E2=80=99m not an expert on Linux=
,  I=E2=80=99m
> posting the issue and possible solution so that it could be implemented
> on a future release.
>=20
> Please, share your thoughts :)

I can't provide further insight but I'm interested if this is possibly
the cause for the general issues people are having with the SD card
reader on Lenovo Miix 320 devices.

Those issues described in posts like

https://vincent-ventures.com/2018/12/arch-linux-on-lenovo-ideapad-miix-320/
https://esc.sh/blog/linux-on-lenovo-miix-320/

are (1) black screen when booting with an SD card installed and (2) when
inserting an SD card after booting it shows up but upon trying to access
it the screen turns black until the card is removed again.

I can confirm (1) on my Lenovo Miix 320-10ICR with kernel version
5.2.11. I can also confirm that only SDXC cards are affected, SD and
SDHC cards work as expected.

Thanks

- Tim

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEsPhBXfDN+Hkdup3Co9aePamg/zQFAl1xaZ8ACgkQo9aePamg
/zSNpQ/+M31HqmG8Iof7k6Oc3Fcoise5gQQsK6KgLkRZ3PvByFKYMUjaR2A9LEOL
oleAFXl2eCCOXAmz1cQ3uWipLdKtF6vCobtjVNkQxNf+4//qZJQQZHKN+R6I60JC
saeZcl89CfwajZyiPvhrdGTgy5ms7DIWOoOLkURr/FkPkcLTOVGcK5asrCn2VvxT
KCT1xgExKSJDaK+18lcQO4sDIUyJ8IwrRBLgNcz5zYECFfC63cM8iISJPSeutQKX
5aRDFVS8WDPh3zgfR+ZI2ikz0IeaFhg6912URv2EH/C+d0/N4IEgTYyb5LU48Ova
xh2wQWUrFw15RvGd2vbQ94DTQ+/kijNBLmzHWovfS/UznCs24Zfp4ZZiLtwAa6u4
SmazBH0nMt4k/Cv0i0saRZRI3R/uRGQhXLbQtL+0ZPwgk0IzenMIv1rdz6+1GPBQ
e3MsQmnPcFozHaej348N7pAiiFQcuKT9Djp6OvyVrJ3T8Aj1oo+S+Q8W+0kn8vd8
Rd0xXiVtT85fhbYigAnrfxo+fRalQ/MOMGVQ9ymCzbdEoIEdoNknnjOEiuurD+VG
wLvHd5tsplRebrrpOOH0IjFKbPS/8XXdho8ZOEWcB2ZBm5zyLvdpfpkPGUjB/zZY
cHwWiQMYExh3iMN6rh6kGNjb4AFEruH7/IXqeC/XAXqCGSkqBuY=
=dlnD
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
