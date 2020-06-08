Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBEEA1F1972
	for <lists+linux-mmc@lfdr.de>; Mon,  8 Jun 2020 14:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgFHM4h (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 8 Jun 2020 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728931AbgFHM4h (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 8 Jun 2020 08:56:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD66C08C5C2;
        Mon,  8 Jun 2020 05:56:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l27so18197192ejc.1;
        Mon, 08 Jun 2020 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3UgnuIt4eUiizz8RKz+CLNlYY+s+snxRvwn2Nqiv8mA=;
        b=hnKDm+e2wot8X7hijnXlTxsjlMzVZArEMQbqShrDH6BDk82Q6ZkDZvU9ieBAB3VXsj
         Sw0/GsjulOpiufvM9GBWh1bFGDpFygFoqIVcxFSAjZM45cWJlpjXeL3ePl5g9RD8bIUE
         6kukCAywLyQ19gqgsYBKwAflTXhxGLjdSh6Qu5fd7mVBJcgM/hi6VHnCyjb4HRe4RrZy
         b7Xkpjf9ogah8/JARCAT5p5Bda1Tbhh3iZXkAF7tgNeBS2mNErfLjAunjpd1wV42eyaD
         jlhLAZCSQMmZxrLezsMEjlvIQMNG9UB2EDzN+3DlOz9LBfzIXnFM0tw49prqWFSt6U+1
         JmPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3UgnuIt4eUiizz8RKz+CLNlYY+s+snxRvwn2Nqiv8mA=;
        b=YUgSmjEoTDPWr5ut1H+sl7v7XGhPMEPIKI6YqgmIpm8uN5YNvdELrEYolG91MiksRT
         DHDeHux2KUQresSsLwXIcLw2KLHcQ7QRCg6HL+lOfhMiZx8sAeGD+xTC2JETLZg/qiAS
         AaWQO0VChht1KOdNgQOBzzK2smvKq8/OgKakxgLy+jbEsb9DyLFgqS0IvSNNFHrWGryB
         8CW3rTyFZOmPMWKJlq+g4zY1g0nhOdeB4SO0H0+T+t8KnOJQjkpu44IRpPHurGZIbovM
         xV65z0ggHDEvh162NNuq2/N61FKaMO8ufqaFeXjWNxv/vFciDlLSV7YtcI/usHlEzXS0
         QATg==
X-Gm-Message-State: AOAM532sBj61khfY7t9EYSQIHqDK3ryMYth/W1DZW49KpX914kwM1th+
        BbbjN78e2gwM7z0g+aVqS+w4HnFx7CqArkdoPmQ=
X-Google-Smtp-Source: ABdhPJyghfSi7+bGOS7SQqFDAcG804xFwgxwAKvBvSPJfgOsYDUEIS+KYDI19lMl7J6498uIrMhJhNEBfHuxmhpBMek=
X-Received: by 2002:a17:906:160a:: with SMTP id m10mr21575123ejd.170.1591620995724;
 Mon, 08 Jun 2020 05:56:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200605125545.31974-1-frank@allwinnertech.com> <20200605151810.vmgnnzp7cadfwsu5@gilmour.lan>
In-Reply-To: <20200605151810.vmgnnzp7cadfwsu5@gilmour.lan>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Mon, 8 Jun 2020 20:54:51 +0800
Message-ID: <CAEExFWuoHhLqt4aukmP30SSXmwnmYuRq2t5HWKUBvreeABg=XQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: sunxi-mmc: do not hide address in sunxi_mmc_irq()
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Frank Lee <frank@allwinnertech.com>, chaotian.jing@mediatek.com,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, rmfrfs@gmail.com, marex@denx.de,
        linux-mmc@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mediatek@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Jun 5, 2020 at 11:18 PM Maxime Ripard <maxime@cerno.tech> wrote:
>
> Hi,
>
> On Fri, Jun 05, 2020 at 08:55:44PM +0800, Frank Lee wrote:
> > From: Yangtao Li <tiny.windzz@gmail.com>
> >
> > Using %px to show the actual address in sunxi_mmc_irq()
> > to help us to debug issue.
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > Signed-off-by: Frank Lee <frank@allwinnertech.com>
>
> I'm fairly sure this hash is on purpose, and both the commit log of the
> %px introduction (ad67b74d2469) and the checkpatch message are pretty
> explicit about it.
>
> What issue were you trying to solve here?

There doesn't seem to be a strong requirement to force this to be printed out,
I just think that ____ptrval____ is very unpleasant.

Or delete %p directly?

Yangtao
