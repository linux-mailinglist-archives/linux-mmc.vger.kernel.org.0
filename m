Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 813C713B510
	for <lists+linux-mmc@lfdr.de>; Tue, 14 Jan 2020 23:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbgANWG0 (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Tue, 14 Jan 2020 17:06:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANWG0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 14 Jan 2020 17:06:26 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D6A42467A;
        Tue, 14 Jan 2020 22:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579039585;
        bh=ak2pDlNLJqO6I6B08zZGpFxARQfKyArhMmTzeALdBzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cCHYW6a6nJENELdOdK6d5nUAFMYQgVeYuz0JQ2jjuOWRxbT6HzRipISp8KrAwsE/u
         F/vedVKRrWV1TGVEFP49MpODow/BWFG/HfxVyMOseoLizNfjTCK+IV0hg2gGnBtLiF
         agiqjC7Y7MER9MoUJUEyXAw7L8s6/5hGa5SBtf1A=
Received: by mail-qv1-f45.google.com with SMTP id dp13so6443169qvb.7;
        Tue, 14 Jan 2020 14:06:25 -0800 (PST)
X-Gm-Message-State: APjAAAUC0xIx0b9UnZe4i1mzE7Endwv1r8JAa+1+RwflJkU+aj0HmUmj
        lqDi2M+8TCfSYopIYp2tZpI11scoEJ84BBKszw==
X-Google-Smtp-Source: APXvYqzGWrbxNauf9xa5MkJ+ERHGXWd3WsUXlRzV0Dnb14EolrJehn1vVApCKSXYdX1ws1nunVbJjQJrO0ev1wSrlWM=
X-Received: by 2002:ad4:450a:: with SMTP id k10mr21746759qvu.136.1579039584558;
 Tue, 14 Jan 2020 14:06:24 -0800 (PST)
MIME-Version: 1.0
References: <20200114213809.27166-1-jbx6244@gmail.com>
In-Reply-To: <20200114213809.27166-1-jbx6244@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 14 Jan 2020 16:06:13 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+8X0oRykiQOKVyaxis4H0yO=nzUtnFF_BXdwBkuigr7g@mail.gmail.com>
Message-ID: <CAL_Jsq+8X0oRykiQOKVyaxis4H0yO=nzUtnFF_BXdwBkuigr7g@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: mmc: combine common mmc and
 dw-mshc properties
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "heiko@sntech.de" <heiko@sntech.de>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, Jan 14, 2020 at 3:38 PM Johan Jonker <jbx6244@gmail.com> wrote:
>
> Combine the common properties for mmc and dw-mshc in
> mmc-controller-common.yaml

Commit messages should explain the why, not what.

AFAICT, the only reason is to not have a node name of 'mmc'. That's
entirely the reason why it is defined. Fix your node names to use the
standard name.



Rob
