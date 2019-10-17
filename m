Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C508CDAC6E
	for <lists+linux-mmc@lfdr.de>; Thu, 17 Oct 2019 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406307AbfJQMh4 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 17 Oct 2019 08:37:56 -0400
Received: from mail-lj1-f171.google.com ([209.85.208.171]:36317 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbfJQMh4 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 17 Oct 2019 08:37:56 -0400
Received: by mail-lj1-f171.google.com with SMTP id v24so2392463ljj.3
        for <linux-mmc@vger.kernel.org>; Thu, 17 Oct 2019 05:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mXbAggIpKNcWMJVyegqHb3OH/40FB9NnShdoi+X9wio=;
        b=Em/+CvNV5aODqpGEXhKW+ic28erWjVQIba3p3VCwhDQUSL8pRJFR6OL0k7sd7Isdju
         ynZ49rWIzwu7vgDRCieWzLqWm/w24J1BCuXL3jO5GGPAzf+hOVArnlfdsPi0VTn50sde
         H5O0P7YLpgWBToOC0E0pujCaXqEiJCXQO9BrXihptIJYD2VG6SVWznhN9XL383S7mGBb
         2/ttBDA/EDFoocjJfX65f1EJyEGxIppNqxUxK9Lb68cY43V/H3E9nhd/+T1BAbJvlvk7
         eq7BqIITb4OXbsMU/Jnc6uHTNowiPnhOhWn4rJHKJjg9uoMhxHX32eqlDIMR5tHqWeIY
         yGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mXbAggIpKNcWMJVyegqHb3OH/40FB9NnShdoi+X9wio=;
        b=h5l/S3Cw96HnfEdLTAHmLvrCzS5YYxjkZm3JZBVNqZsAbWn3jYBTVvuVjyI+6fYFFJ
         39w+iFJ5ivdf3zxt2n+KqJCClKlwPiSBHL9OI3SzqFvsuyS9OILiNgyppyVLj/xZ1NN2
         YDh2CBoAbhkFqnHL8opV1lwpoyeBdngc1nTAfZu4oiH+pjMMLyeiEXayRZt+H10NlnuI
         6J+8D7fAxpVn1fk7eh3KhHB5LWyGacI7WeViDGIlZKf4ei89jfmkE6Lwv8cTQN/jPcTy
         Y7JPN2+43NuCwsSgiu3Qt2ZxbPgEmC3SxXMFDX5BVROUQDQKz21EEDUQAISUG1/YT1cs
         +peg==
X-Gm-Message-State: APjAAAVTp/mplZo3E1Qs8HHQoftOAExzbGc8Jf+Ierw0xBtihwA1+QsQ
        d7ZPD3n6zdkSmz24wiHQzJvuwFCNlG+DYF6MSG8=
X-Google-Smtp-Source: APXvYqwioIc5zIdYAnaxY0bOdmToo/0BAwxwoPhiAMmHuEOMXH/Wbi/94JXmcyNbe4gHoQRG9Qaw1QHPsunDaxVuNRY=
X-Received: by 2002:a2e:b4d5:: with SMTP id r21mr2349562ljm.149.1571315874417;
 Thu, 17 Oct 2019 05:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5ACYH_vuf4FevsPNkdxt8Y0irFeDNDcFns1bhsxB=M68w@mail.gmail.com>
 <20191015144054.kd2cgn2xhctr6x3w@pengutronix.de> <CAOMZO5CDKTdDCV6LDEeSzQScCmLc14oRJgDq0h4eSX5vmqTbpg@mail.gmail.com>
In-Reply-To: <CAOMZO5CDKTdDCV6LDEeSzQScCmLc14oRJgDq0h4eSX5vmqTbpg@mail.gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 17 Oct 2019 09:37:45 -0300
Message-ID: <CAOMZO5DMr680FZYfpeakOSbSwg03z_e0wPXLZOeNqsOvFPUGxA@mail.gmail.com>
Subject: Re: mmc failure on mx28 running 5.3.2
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Marek Vasut <marex@denx.de>, Stefan Wahren <info@lategoodbye.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Sascha,

On Wed, Oct 16, 2019 at 10:53 AM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Sascha,
>
> On Tue, Oct 15, 2019 at 11:40 AM Sascha Hauer <s.hauer@pengutronix.de> wrote:
>
> > Have you seen https://www.spinics.net/lists/linux-mtd/msg09535.html? I
> > think your issue is something else though.
>
> I will test your proposed patch, thanks!

I applied your patch against 5.3.6 and it fixed the MMC issue.

Thanks
