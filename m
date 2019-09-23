Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D12A5BB775
	for <lists+linux-mmc@lfdr.de>; Mon, 23 Sep 2019 17:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfIWPFc (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 23 Sep 2019 11:05:32 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:33628 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfIWPFc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Sep 2019 11:05:32 -0400
Received: by mail-io1-f68.google.com with SMTP id z19so12067766ior.0
        for <linux-mmc@vger.kernel.org>; Mon, 23 Sep 2019 08:05:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JuX2rLU57GT+Y8rUnSSH6B3s8i9gk/5paFdgTU9DWiY=;
        b=mJv/P/mMIE6XluWgUqszoGPeCL2jnsRZNfk8WNGHKsfSsMS8OKe3js1xc2D5SXPFXK
         zTf/jUK4ryz0Y3Cq7i4uWEn3vm9cRsUZ+5Sq8Cf3HR//KcTwrjU1QMUUMQzsqcKCjGjn
         mZxsMwDmplfKPN6vKc6C0WPJiYf+d9+BYTPXPyrl6vZf8gGea+Kri4c0trTiM3VE4s+l
         mD0sSkQWKwWwPvx7uCsPqaxW2522F70omgwmNMQxJjMAaUXrlA2N5+R1SVTQAHrnc1r9
         AXqjIz6Swyfb0liMwnfo9WzSzMtFuPJOawXVRikVQSywhXvwwgNXaZCJiLqGAJTiyhUu
         qngw==
X-Gm-Message-State: APjAAAUHuN72PiT4BNfTuwyfT6lvbc4pAdwjmAkTUojb8y+4bop5JLHs
        VuZMX5kiSk/RwZR7TvZ0BKIB81lFLXA=
X-Google-Smtp-Source: APXvYqzNYw1uoc+qJws3WvoJ6LDxJQjnnp1OTVsd2EZQW61C+MP2pNPFjJ92YMGHdXL2vegLiYGqkA==
X-Received: by 2002:a6b:6f0e:: with SMTP id k14mr2098114ioc.255.1569251131775;
        Mon, 23 Sep 2019 08:05:31 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:82e0:aef8:11bc:24c4])
        by smtp.gmail.com with ESMTPSA id p26sm7881515iob.50.2019.09.23.08.05.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2019 08:05:30 -0700 (PDT)
Date:   Mon, 23 Sep 2019 09:05:26 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: sdhci: Check card status after reset
Message-ID: <20190923150526.GA116813@google.com>
References: <20190904164625.236978-1-rrangel@chromium.org>
 <6e65c246-a485-91c8-53e1-2ad0319a1e89@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e65c246-a485-91c8-53e1-2ad0319a1e89@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, Sep 23, 2019 at 03:31:59PM +0300, Adrian Hunter wrote:
> Should have Acked this ages ago, sorry :-(
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, and no worries :)

Ulf, The patch set is ready to merge now :)
