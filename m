Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E67FCBAEBD
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405191AbfIWHyA (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 03:54:00 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43542 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405395AbfIWHyA (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2019 03:54:00 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so9314514lfl.10
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2019 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5+GerYcmYMO5YvdQkT9Zn07Af1kbLUNX6Y/+zHLXd0M=;
        b=cxP+eNFJeT5F7TXm7atEyHSr+rSnR0aDK+1Ma2XO3DcJMuXnJi3Kyiblt4jzyxaAgY
         iQsQQx61Vyx07Lf5+MXyG+KFgsme4snyfnEmCQcMe6HPIfWd1uAwyGlhQ9wFzheHpHNF
         9kBUomEAJ5cIgxpxx1dW7u1pc9ClpQl3q48Le6vpIYMFMuvxLCzJ9UUc0sWP0F9f1HQS
         TijYSh1rchb3JIi7BvctqmmwmS/dLORk3PROROTTZxiAaALC/4/x0XRW89hvN6N2MxvF
         eqS/h+VXoB4MKNPUtUypd2drjogttxVHJBNGuV9bZzXzqWEQL2I92tvi58htdPtonp6S
         CU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5+GerYcmYMO5YvdQkT9Zn07Af1kbLUNX6Y/+zHLXd0M=;
        b=lr6KUK11A3Eay7CSyMm2WVCTiXPpWjspekRLUyn3D+Q8yuZqtYJuY9TIOF7PuV97jv
         Oa9IduEKqogLvoEtqEKSjACYmiokuKGSZYLTkklCvepOMuBMqHhUKbEZ5rwIjim3qmJV
         bCfBoqb2geesyjR+5lUISv77Em0mTcNh5e159KPArg1xIRiaMXihBEL5inPS25fyUeBX
         1vFD/xH0qUHK6MraDpHNaR7ZA7AelUI2iWss2iF+3NSuPKlm0LQPNJ1ilVqFbKBthtcq
         HF7rHk4q5d8+Wc28ypR9edLH2IF/q+Dujia4swzvf6z6KJTA+uXO6kFm/USxODuUPoMt
         sd0w==
X-Gm-Message-State: APjAAAUSXChmNU2RtRDGoLvnHQS9qhbryWye7U++cu8t7ElsVTimFT0B
        OH+SyqeHvBYv3jZHMbGwFt1VdwnILRbKlBEBxLlyTA==
X-Google-Smtp-Source: APXvYqygvtnIx3QdOPmtm3Dh6aqMWmYMQVt8wtC93BSYUtfHNLQsNjV49z9+Q2sxHmdCkSPAzmVRPbM40h0JA4wnEV0=
X-Received: by 2002:ac2:5148:: with SMTP id q8mr15155737lfd.84.1569225236069;
 Mon, 23 Sep 2019 00:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <63395d0c73f0bb1cf7c2f52545137fd4014f84ba.1568864712.git.baolin.wang@linaro.org>
 <20190921144922.GB13091@xsang-OptiPlex-9020>
In-Reply-To: <20190921144922.GB13091@xsang-OptiPlex-9020>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 23 Sep 2019 15:53:44 +0800
Message-ID: <CAMz4kuJONoMYAmQrKukxxpDbYDQQ8G7SYaL4svk8A6ewr2sYEA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] mmc: Add MMC software queue support
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, asutoshd@codeaurora.org,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Sat, 21 Sep 2019 at 22:43, kbuild test robot <lkp@intel.com> wrote:
>
> Hi Baolin,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [cannot apply to v5.3 next-20190918]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/mmc-Add-MMC-software-queue-support/20190919-140107
> config: i386-allmodconfig (attached as .config)
> compiler: gcc-7 (Debian 7.4.0-13) 7.4.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=i386
> :::::: branch date: 7 hours ago
> :::::: commit date: 7 hours ago
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    ld: drivers/mmc/host/sqhci.o: in function `sqhci_finalize_request':
> >> (.text+0x644): undefined reference to `mmc_cqe_request_done'

OK. I will fix this issue in the next version and wait for a while to
see if there are any new comments for this patch set. Thanks.

-- 
Baolin Wang
Best Regards
