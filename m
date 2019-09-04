Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8E2A7F76
	for <lists+linux-mmc@lfdr.de>; Wed,  4 Sep 2019 11:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbfIDJdp (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Wed, 4 Sep 2019 05:33:45 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33444 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729229AbfIDJdo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Sep 2019 05:33:44 -0400
Received: by mail-ua1-f68.google.com with SMTP id g11so6510018uak.0
        for <linux-mmc@vger.kernel.org>; Wed, 04 Sep 2019 02:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Q3j0a3Va0LILUbftY+GrXeWgsFCC2hnB8/26iKXZT1A=;
        b=jqhuORz5LRSTHE6yt9hdascFr7gMHYN103bOmBaep6127Qya3qjDukMlGpegWxRMZv
         ON0jdjcvzdh8vkTyD5dnXmhSebSrDj9JQHlOSwyEga7W5Kp0QOb47w7dLnGDhylvyr54
         hPNzF3xQTlOw0d0ZrW6fUU20nP4I56aAXLh6GiIavwU32gz3PV7i3YZ8YHJxKni1DdCt
         kB8yBfCEHp0i74IhgSIYgj8w4yy3O4irTba0lbnEizx3eefKcUIftImJrg5Uyf7ePgmz
         PKcRwipPk43fuo3ST53fkMBUMrOq4ehB/+P4mwh3doDfk7ZJ2so1FBVcStac/6408m1t
         m2Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Q3j0a3Va0LILUbftY+GrXeWgsFCC2hnB8/26iKXZT1A=;
        b=PlLQlzhah0nUbRdUrX1WkYLCrXpKdxHLh5oTusIAwTgccKM93HlWByhO0JdIwgUrxk
         WiywXBsxJtoBR7uLKD8j/oTMUogeg5HNDDp+wxhrJDSR+7KuHM9C6ViP/OzHAVcFk9+J
         mZ2BVgnAUQiyFt46PxjpJUGmhZ2IluwZQy1+CIaQvtii6Zai+5zHKfgstI68My9c933D
         D+NFhmyFaVEncr/VnFKrtEgtFsbycHhW1EWyljKk4vIILMM5zD4jWh22rtMDec1V4ZUR
         eNJtsQv0fNSfmF8GGLS/KtBl4tSPZXmZnfOqeqyQcwpJETekwC1v4Bq4YFhVJrs3uRJA
         qYYg==
X-Gm-Message-State: APjAAAXeeD+es6VW4Mllpp7aARiO2yXDRJBrSLhRTMXG4OMqhlHmKfNm
        xBVJlIEGd2ArMVqFgyycpBGtofuOfOuufto4Re7G6w==
X-Google-Smtp-Source: APXvYqz9j4GhmvTsAglNcvbdHH9GGXTS4jNOSKlZBReCRMOyxFxcXtxwVlgUVi/RzOQyWDDCDgYkofWSDUZ4OId8sms=
X-Received: by 2002:ab0:6601:: with SMTP id r1mr5312898uam.100.1567589623643;
 Wed, 04 Sep 2019 02:33:43 -0700 (PDT)
MIME-Version: 1.0
References: <d355e790-7c60-5681-3ea5-dc4fd6206628@zoho.com>
In-Reply-To: <d355e790-7c60-5681-3ea5-dc4fd6206628@zoho.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Sep 2019 11:33:07 +0200
Message-ID: <CAPDyKFqKxSo50FSmesuOBz+FfE_DEFsZmEHD5CiU8SORv1Jrow@mail.gmail.com>
Subject: Re: Asus VivoBook Flip TP202NA-EH012T EMMC problem
To:     =?UTF-8?B?w5N2w6FyaQ==?= <ovari123@zoho.com>,
        Kai Heng Feng <kai.heng.feng@canonical.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Kai Heng Feng

On Sat, 31 Aug 2019 at 11:43, =C3=93v=C3=A1ri <ovari123@zoho.com> wrote:
>
> Hello,
>
> As per https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1818407/comme=
nts/26 here is an email.
>
> Information is provided at https://bugs.launchpad.net/ubuntu/+source/linu=
x/+bug/1818407/comments/32
>
> Please advise what else you require.

Future wise, rather than solely sending links to bugreports, please
copy the relevant data into the email. Moreover, we don't normally
care that much about "old" kernels, unless problems exists on the
latest kernels as well.

Anyway, by following the above links, I figured this is about
sdhci-pci and you get a CRC problem when switching to HS400 mode.

[ 3.673358] mmc0: error -84 whilst initialising MMC card
[ 3.808029] mmc0: mmc_select_hs400 failed, error -84

A wild shot is to try out my fixes branch, which holds the following
below queued fix, that might solve the problem if it's a regression.

commit 8ad8e02c2fa70cfddc1ded53ba9001c9d444075d
Author: Jan Kaisrlik <ja.kaisrlik@gmail.com>
Date:   Tue Aug 20 13:42:29 2019 +0200
Revert "mmc: core: do not retry CMD6 in __mmc_switch()"

git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git fixes

Kind regards
Uffe
