Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Original-To: lists+linux-mmc@lfdr.de
Delivered-To: lists+linux-mmc@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6C5E1BBA7
	for <lists+linux-mmc@lfdr.de>; Mon, 13 May 2019 19:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbfEMRTP (ORCPT <rfc822;lists+linux-mmc@lfdr.de>);
        Mon, 13 May 2019 13:19:15 -0400
Received: from mail-it1-f180.google.com ([209.85.166.180]:53192 "EHLO
        mail-it1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfEMRTP (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 13 May 2019 13:19:15 -0400
Received: by mail-it1-f180.google.com with SMTP id q65so297998itg.2
        for <linux-mmc@vger.kernel.org>; Mon, 13 May 2019 10:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=edXm6nV8k9IKw8GN0v7pjwQG3EECmvNTVGBhaoXBOy8=;
        b=ZiTkdglJI/3iYxtD3CeuFQfL+i+RAj3L58kB2dtL2NSFaYKkSjF/eMqtnnegdI7F2o
         uyR9fEAV7qawt16XWtBz+qfI1B8fMeP++bWKFGfAxe5ztmQtfCKZkYSExtvAAmsJe7h0
         QKy3tiY58T59XzjNwLsX8fDjSrIvLw2iB3K9g/E9vxK6UN23hwlWmPEFrguJksd8FjzS
         bdFOgkDfjVvnugrZpRSv/ZQuccWl9bNgRW/fP8VbFkSyhstW/LxvU+ZSppS/g3JyjU5r
         axNs/Ym+UJIGZayiEKOAIJURkfhwvkEs3imsTs35tjxlCWdrlNLJWTv6M6wS94URQlOo
         mLZw==
X-Gm-Message-State: APjAAAVLmvsv9jTGMpMF+Ofim7s4TuvX1EykkwVhA6ePF5S8dL4YBWAQ
        i121/aNHslLB4QWSv+/gscMBQ3fvndQ=
X-Google-Smtp-Source: APXvYqzzkTdZunaul5S9hyndOLjl1eWjL1tIFwSvNm8zSLCNYZNkVziz0TnYEOaYSFGWvDFTOA5LHw==
X-Received: by 2002:a05:6638:310:: with SMTP id w16mr12108468jap.130.1557767954280;
        Mon, 13 May 2019 10:19:14 -0700 (PDT)
Received: from google.com ([2620:15c:183:0:20b8:dee7:5447:d05])
        by smtp.gmail.com with ESMTPSA id x11sm1190741ion.10.2019.05.13.10.19.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 13 May 2019 10:19:12 -0700 (PDT)
Date:   Mon, 13 May 2019 11:19:08 -0600
From:   Raul Rangel <rrangel@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mmc@vger.kernel.org, djkurtz@google.com,
        adrian.hunter@intel.com, zwisler@chromium.org,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] mmc: v4.14: Fix null pointer dereference in
 mmc_init_request
Message-ID: <20190513171908.GA37248@google.com>
References: <20190508185833.187068-1-rrangel@chromium.org>
 <20190509060456.GA17096@infradead.org>
 <20190509184234.GA197434@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509184234.GA197434@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

> > Errm.  I think we need to fix that problem instead of working around it.
> So mmc_request_fn already has a null check, it was just missing on
> mmc_init_request.
>
So I got 189650 random connect/disconnect iterations over the weekend
with these patches. I think they are fine. I'm going to send them to
stable@ unless anyone has any objections.

Thanks,
Raul
