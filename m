Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFA8BF734
	for <lists+linux-mmc@lfdr.de>; Thu, 26 Sep 2019 18:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfIZQ4s (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Thu, 26 Sep 2019 12:56:48 -0400
Received: from mail-lj1-f180.google.com ([209.85.208.180]:46985 "EHLO
        mail-lj1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbfIZQ4s (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Sep 2019 12:56:48 -0400
Received: by mail-lj1-f180.google.com with SMTP id d1so1870309ljl.13
        for <linux-mmc@vger.kernel.org>; Thu, 26 Sep 2019 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kBowK7TWmJVGxLzKO1vf00Bi1k9GFMvujKzJ43Tue4Y=;
        b=tv7KvC2bzbPFUbOVh5d0MiTFwH/XPflbm3a338HIVOEdCxkkJtbabuoDKMULoHRJ/Y
         8wGLig9LJE/pVqsrWpjxLCcaM+B9wqS+lbebKNrnjd+A0XMhacPL//Zw6mc92iIGGHve
         isQrLrykcwwIP/+iR0avyaCJVVn9WNFEXI/pqkTemgVmKcTLuvLBLpYHqYys62WXmlCG
         18iXOt66/rNi2fIPOyKtjh/LRluGyuc5VYnEtGmETtILMcP5j0iItrwox9U3eH+/Nld4
         ZkoVZDvUry38i0eEr2bs9rWDkeqEMhVxdpsyfcFojudNATDguShfvG/+yulCU+hSWGpx
         xwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kBowK7TWmJVGxLzKO1vf00Bi1k9GFMvujKzJ43Tue4Y=;
        b=POOPaySAyoKPu5b5zwnd4Q02jL48qoR52nasvLhoJnDPSXpTdo3cVJnsTED7IiPkcG
         QoRlRDKYwa/CP1uanpqluPPwJIDUqlc2eLS5ZmvcffuNoxOl9Jjw/w/c727GOTjXJS3a
         bc5eFJug9zrEBmXDgIn+WR6pTp2YOQPRZAhsdXE/gY2MxK4YuUW0fy0d+Q/+pjMKpoWf
         zfue+QOzoYDa3KRVXRArrPhfnmnVxH339jWuUweqA9k0Hc1TGFbQWoGox0dhP/+HiW3k
         1m0SjV7kyixNqtdakAa8nYhvTLUNgt3TZy8vNlGcXlP0fKNa5WHhJH/ZR4pTkAHQoiqm
         Dj4Q==
X-Gm-Message-State: APjAAAW/UVkebEutHRRYAbUaDWutVSi9Y4mF/rrVXRSoTil2X8H3W4pY
        s+ZfhavA+QEZm8Ml0LRZODSi/DfJBpIlyKuCO22l5mHM
X-Google-Smtp-Source: APXvYqxfhby9YZG5l8z9Ky8ffShJ/jxI62N+5F2lkiB740ZzmxSwITv87otAhZWQ5RJOAoeme0HkToOEfwC8Xv/Blwg=
X-Received: by 2002:a2e:9d44:: with SMTP id y4mr2141272ljj.115.1569517006234;
 Thu, 26 Sep 2019 09:56:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAOMZO5DmkV10xrz7g_JzU-LokoxcCair_2xP4S-ZBCtmnprhZA@mail.gmail.com>
 <DB3PR0402MB39164C0B4789A08A1FC557C3F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
In-Reply-To: <DB3PR0402MB39164C0B4789A08A1FC557C3F5860@DB3PR0402MB3916.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 26 Sep 2019 13:56:57 -0300
Message-ID: <CAOMZO5B2Jiy-nCU7+ksn7NOFTUtD=LL0KiHfT0cnai4C=hDi-Q@mail.gmail.com>
Subject: Re: SD card failure on i.MX7ULP EVK
To:     Anson Huang <anson.huang@nxp.com>
Cc:     BOUGH CHEN <haibo.chen@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Anson,

On Wed, Sep 25, 2019 at 9:26 PM Anson Huang <anson.huang@nxp.com> wrote:
>
> Hi, Fabio
>         See attached patch, this is due to HW special requirement, but clock maintainer does NOT ack my patch, he prefer to fix it from clock core driver, but I think that make things complicated and also it looks like NOT feasible.

Thanks.

It would be nice if you could resend the clk patch to Stephen so that
the solution can be discussed.
